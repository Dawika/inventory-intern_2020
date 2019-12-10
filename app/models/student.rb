class Student < ApplicationRecord
  include ActiveModel::Dirty
  include Rails.application.routes.url_helpers

  belongs_to :grade
  belongs_to :classroom
  belongs_to :gender
  belongs_to :school, -> { with_deleted }
  has_and_belongs_to_many :parents, join_table: 'students_parents'
  has_and_belongs_to_many :relationships, join_table: "students_parents"
  has_many :invoices, -> { with_deleted }

  has_many :roll_calls
  has_many :student_lists, dependent: :destroy
  alias_attribute :code, :id
  alias_attribute :number, :classroom_number
  attr_accessor :first_name, :last_name, :prefix, :active_invoice_status

  self.per_page = 10

  validates :full_name, presence: true, unless: ->(obj){obj.full_name_english.present?}
  validates :full_name_english, presence: true, unless: ->(obj){obj.full_name.present?}
  # validates :student_number , uniqueness: true , allow_nil: true

  acts_as_paranoid
  has_attached_file :img_url
  validates_attachment_content_type :img_url, content_type: /\Aimage\/.*\z/

  after_save :update_rollcall_list
  before_save :clean_full_name
  after_destroy :manual_destroy_recursively


  def update_rollcall_list
    if self.classroom_id && self.classroom_id_changed?
      # add or update list
      StudentList.transaction do
        self.student_lists.destroy_all
        list = List.where(name: self.classroom.name).first
        if !list
          list = List.create(name: self.classroom.name, category: "roll_call")
          Student.where(classroom: self.classroom).pluck(:id).each do |student_id|
            StudentList.create(student_id: student_id, list_id: list.id)
          end
        else
          student_ids = Student.where(classroom: self.classroom).pluck(:id)
          exclude_student_ids = StudentList.where(list_id: list.id).pluck(:student_id)
          (student_ids - exclude_student_ids).each do |student_id|
            StudentList.create(student_id: student_id, list_id: list.id)
          end
        end
      end
    elsif self.classroom.blank?
      # remove list
      self.student_lists.destroy_all
    end
  end

  def clean_full_name
    self.full_name = Student.clean_full_name(self.full_name)
    self.full_name_english = Student.clean_full_name(self.full_name_english)
  end

  def self.clean_full_name(full_name)
    if full_name
      full_name = full_name.gsub('ด.ช.', '')
      .gsub('ด.ญ.', '')
      .gsub("ดช" , '')
      .gsub('ดญ' , '')
      .gsub('เด็กหญิง', '')
      .gsub('เด็กชาย', '')
      .gsub('Master', '')
      .gsub('master', '')
      .gsub('Miss', '')
      .gsub('miss', '')
      .strip.gsub(/\s+/,' ')
    end
  end

  def full_name_with_title
    title = ""
    title = "ด.ช." if self.gender_id == 1
    title = "ด.ญ." if self.gender_id == 2
    thaiName = self.full_name.nil? ? "" : self.full_name
    engName = self.full_name_english.nil? ? "" : self.full_name_english
    if I18n.locale == :en
      if !engName.blank?
        title = "Master" if self.gender_id == 1
        title = "Miss" if self.gender_id == 2
        return "#{title} #{engName}".strip
      else
        return "#{title} #{thaiName}".strip
      end
    else
      if !thaiName.blank?
        return "#{title} #{thaiName}".strip
      else
        title = "Master" if self.gender_id == 1
        title = "Miss" if self.gender_id == 2
        return "#{title} #{engName}".strip
      end
    end
  end

  def nickname_eng_thai
    if self.nickname && self.nickname.size > 0 && self.nickname_english && self.nickname_english.size > 0
      if self.nickname != self.nickname_english
        return "#{self.nickname} (#{self.nickname_english})"
      else
        return self.nickname
      end
    elsif self.nickname_english && self.nickname_english.size > 0
      return self.nickname_english
    else
      return self.nickname
    end
  end

  def get_nickname
    if self.nickname_english && self.nickname_english.size > 0
      return self.nickname_english
    else
      return self.nickname
    end
  end

  def grade_name
    if self.grade
      return self.grade.name
    else
      return ''
    end
  end

  def grade_name_with_title_classroom
    if self.classroom.blank?
      if self.grade
        return self.grade.name
      else
        return ""
      end
    else
      return self.grade.name + ' (' + self.classroom.name + ')'
    end
  end

  def parent_names
    parent_ids = StudentsParent.where(student_id: self.id).to_a.collect(&:parent_id)
    Parent.with_deleted.where(id: parent_ids).all.collect(&:full_name).join(', ')
  end

  def parent_and_relationship_names
    results = []
    StudentsParent.where(student_id: self.id).to_a.each do |sp|
      results << {
        priority: sp.relationship_id,
        relationship_name: sp.relationship.name,
        parent_name: Parent.with_deleted.where(id: sp.parent_id).first.full_name
      }
    end
    return results.sort_by{ |obj| obj[:priority] }
  end

  def active_invoice
    if self.all_active_invoices_year.include?(@year)
      current_invoice = self.all_active_invoices.where(school_year: @year, semester: @semester)
      if current_invoice.size > 0
        current_invoice.each do |i|
          if !i.is_cancel
            i.line_items.each do |l|
              if l.detail =~ /Tuition/
                return i
              end
            end
            return i
          end
        end
        return nil
      else
        return nil
      end
    end
  end

  def all_active_invoices
    if self.invoices.size > 0
      @all_active_invoices = self.invoices
    else
      @all_active_invoices = nil
    end
  end

  def all_active_invoices_year
    self.all_active_invoices.nil? ? '' : self.invoices.pluck(:school_year).uniq
  end

  def is_active_invoice_year_semester(year, semester)
    @year = year
    @semester = semester
    if self.all_active_invoices_year.include?(year)
      current_invoice = self.all_active_invoices.where(school_year: year, semester: semester)
      if current_invoice.size > 0
        current_invoice.each do |i|
          if !i.is_cancel
            i.line_items.each do |l|
              if l.detail =~ /Tuition/
                return true
              end
            end
          end
        end
        return false
      else
        return false
      end
    end
  end

  def all_active_invoices_tuition_fee
    @all_active_invoices_tuition_fee = 0.0
    if self.all_active_invoices != nil
      self.all_active_invoices.each do |invoice|
        if invoice.tuition_fee != nil && invoice.school_year == @year && invoice.semester == @semester && !invoice.is_cancel
          @all_active_invoices_tuition_fee += invoice.tuition_fee
        end
      end
    else
      @all_active_invoices_tuition_fee = 0.0
    end

    if @all_active_invoices_tuition_fee > 0
      return @all_active_invoices_tuition_fee
    else
      return ""
    end

  end

  def all_active_invoices_other_fee
    @all_active_invoices_other_fee = 0.0
    if self.all_active_invoices != nil
      self.all_active_invoices.each do |invoice|
        if invoice.other_fee != nil && invoice.school_year == @year && invoice.semester == @semester  && !invoice.is_cancel
          @all_active_invoices_other_fee += invoice.other_fee
        end
      end
    else
      @all_active_invoices_other_fee = 0.0
    end

    if @all_active_invoices_other_fee > 0.0
      return @all_active_invoices_other_fee
    else
      return ""
    end

  end

  def all_active_invoice_total_amount
    all_active_invoice_total_amount = self.all_active_invoices_tuition_fee.to_f + self.all_active_invoices_other_fee.to_f
    if all_active_invoice_total_amount > 0
      return all_active_invoice_total_amount
    else
      return ""
    end
  end

  def active_invoice_status
    if @active_invoice_status == nil
      @active_invoice_status = self.active_invoice.nil? ? 'ยังไม่ได้ชำระ' : (self.active_invoice.invoice_status.name == 'Active' ? 'ชำระแล้ว' : 'ยังไม่ได้ชำระ')
    else
      @active_invoice_status
    end
  end

  def active_invoice_status=(value)
    @active_invoice_status = value
    @active_invoice_payment_method = ""
    @active_invoice_tuition_fee = self.all_active_invoices_tuition_fee
    @active_invoice_other_fee = self.all_active_invoices_other_fee
    @active_invoice_total_amount = self.active_invoice_total_amount
    @active_invoice_created_at = ""
  end

  def active_invoice_payment_method
    if @active_invoice_payment_method == nil
      self.active_invoice.nil? ? '' : self.active_invoice.payment_methods.collect(&:payment_method).join(', ')
    else
      @active_invoice_payment_method
    end
  end

  def active_invoice_custom_fee(type)
    self.all_active_invoices_other_fee
  end

  def active_invoice_tuition_fee
    self.all_active_invoices_tuition_fee
  end

  def active_invoice_entrance_fee
    self.active_invoice.nil? ? '' : self.active_invoice.entrance_fee
  end

  def active_invoice_other_fee
    self.all_active_invoices_other_fee
  end

  def active_invoice_total_amount
    self.all_active_invoice_total_amount
  end

  def active_invoice_created_at
    if @active_invoice_created_at == nil
      self.active_invoice.nil? ? '' : self.active_invoice.created_at
    else
      @active_invoice_created_at
    end
  end

  def active_invoice_year
    self.active_invoice.nil? ? '' : self.active_invoice.school_year
  end

  def active_invoice_semester
    self.active_invoice.nil? ? '' : self.active_invoice.semester
  end

  def self.search(search)
    search.sub!(/^[0]+/,'') if search # remove leading by zero
    if search
      where("full_name ILIKE ? OR nickname ILIKE ? OR student_number::text ILIKE ? OR full_name_english ILIKE ? OR nickname_english ILIKE ? ",
       "%#{search}%", "%#{search}%", "%#{search}%" , "%#{search}%" , "%#{search}%" )
    else
      all
    end
  end

  def first_name
    self.full_name.present? ? self.full_name.gsub(/\s+/m, ' ').strip.split(" ")[0] : ""
  end

  def first_name_eng
    self.full_name_english.present? ? self.full_name_english.gsub(/\s+/m, ' ').strip.split(" ")[0] : ""
  end

  def first_name_thai_or_eng
    self.first_name.present? ? self.first_name : self.first_name_eng
  end

  def first_name=(value)
    full_name = self.full_name
    full_a = Array.new
    if !full_name.nil?
      full_a = full_name.gsub(/\s+/m, ' ').strip.split(" ")
    end
    full_a[0] = value
    self.full_name = "#{full_a.join(' ')}"
  end

  def last_name
    return "" unless self.full_name
    return self.full_name.gsub(/\s+/m, ' ').strip.split(" ").drop(1).join(' ')
  end

  def last_name_eng
    return "" unless self.full_name_english
    return self.full_name_english.gsub(/\s+/m, ' ').strip.split(" ").drop(1).join(' ')
  end

  def last_name_thai_or_eng
    self.last_name.present? ? self.last_name : self.last_name_eng
  end

  def last_name=(value)
    full_name = self.full_name
    full_a = full_name.gsub(/\s+/m, ' ').strip.split(" ")
    self.full_name = "#{full_a[0]} #{value}"
  end

  def prefix
    if self.gender_id == 1
      return "ด.ช."
    elsif self.gender_id == 2
      return "ด.ญ."
    else
      return ""
    end
  end

  def prefix=(value)
    if value == "ด.ช." || value.include?("ช")
      self.gender_id = 1
    elsif value == "ด.ญ." || value.include?("ญ")
      self.gender_id = 2
    else
      self.gender_id = nil
    end
  end

  def missing
    missingCount = 0
    dateStart = Time.now - Time.now.day.days + 1.days
    (0..(Time.now.day-2)).each do |i|
      date = dateStart + i.days
      rollcall = RollCall.where(check_date:date.strftime("%Y-%m-%d"))
      student_rollcall = rollcall.where(student_id:self.id, round:'morning').first

      if !student_rollcall.nil?
        missingCount += 1 if student_rollcall.status == "0"
        missingCount += 1 if student_rollcall.status == "1"
        missingCount += 1 if student_rollcall.status == "2"
      end
    end

    return missingCount
  end

  def roll_call
    RollCall.where(student_id:self.id)
  end

  def full_name_eng_thai_with_title
    title = ""
    title = "ด.ช." if self.gender_id == 1
    title = "ด.ญ." if self.gender_id == 2
    thaiName = self.full_name.nil? ? "" : self.full_name
    engName = self.full_name_english.nil? ? "" : self.full_name_english

    if !thaiName.blank? && !engName.blank?
      return "#{title} #{thaiName} (#{engName})".strip
    elsif !thaiName.blank? && engName.blank?
      return "#{title} #{thaiName}".strip
    elsif thaiName.blank? && !engName.blank?
      title = "Master" if self.gender_id == 1
      title = "Miss" if self.gender_id == 2
      return "#{title} #{engName}".strip
    end
  end

  def invoice_screen_full_name_display
    if nickname.to_s.strip != '' && !self.full_name.blank?
      return full_name_with_title + ' (' + nickname.to_s.strip + ')'
    elsif nickname_english.to_s.strip != '' && !self.full_name_english.blank?
      return full_name_with_title + ' (' + nickname_english.to_s.strip + ')'
    else
      full_name_with_title
    end
  end

  def full_name_with_title_classroom
    if(classroom.to_s.strip != '')
      full_name_with_title + ' (' + classroom.to_s.strip + ')'
    else
      full_name_with_title
    end
  end

  def invoice_screen_student_number_display
    if(student_number)
      "#{student_number} : #{invoice_screen_full_name_display}"
    else
      invoice_screen_full_name_display
    end
  end

  def student_number
    if school && school.school_settings.first
      student_number_leading_zero = school.school_settings.first.student_number_leading_zero
    else
      student_number_leading_zero = SiteConfig.get_cache.student_number_leading_zero
    end

    self[:student_number].nil? ? "-" : self[:student_number].to_s.rjust(student_number_leading_zero, '0')
  end

  def edit
    ActionController::Base.helpers.link_to I18n.t('.edit', :default => '<i class="fa fa-pencil-square-o" aria-hidden="true"></i> แก้ไข'.html_safe), edit_student_path(self) ,:class => 'btn-edit-student-parent'
  end

  def gender
    Gender.find_by_id_cached(gender_id)
  end

  def restore_recursively
    Student.transaction do
      deleted_min = self.deleted_at - 2.minutes
      deleted_max = self.deleted_at + 2.minutes
      # restore all destroy by dependent: :destroy
      self.restore(recursive: true, recovery_window: 2.minutes)
      # restore all manual destroy
      student_parent = StudentsParent.with_deleted.where(student_id: self.id).first
      student_parent.restore if student_parent
      _parent_ids = self.parent_ids
      Parent.with_deleted.where(id: _parent_ids, deleted_at: deleted_min..deleted_max).each do |parent|
        parent.restore(recursive: true, recovery_window: 2.minutes)
      end
      # remove alumni
      Alumni.where(student_id: self.id).destroy_all
    end
  end

  def graduate
    move_to_alumni("จบการศึกษา")
  end

  def resign
    move_to_alumni("ลาออก")
  end

  def move_to_alumni(status)
    Student.transaction do
      if self.deleted_at.blank? && self.destroy
        alumni = Alumni.newByStudent(self)
        alumni.status = status
        alumni.save
      end
    end
  end

  def manual_destroy_recursively
    Student.transaction do
      _parent_ids = self.parent_ids
      Parent.where(id: _parent_ids).each do |parent|
        if parent.students.length == 0
          StudentsParent.where(parent_id: parent.id).first.destroy
          parent.destroy
        end
      end
      StudentsParent.where(student_id: self.id).destroy_all
    end
  end

  def parent_ids
    return StudentsParent.where(student_id: self.id).to_a.collect(&:parent_id)
  end

  def img_medium
    self.img_url.exists? ? self.img_url.expiring_url(10, :medium) : ''
  end

  def as_json(options={})
    if options['index']
      return {
        img_url: self.img_medium,
        full_name: self.full_name_eng_thai_with_title,
        nickname: self.nickname.nil? ? "" : self.nickname_eng_thai,
        grade_id: self.grade.nil? ? "" : self.grade.name,
        classroom_id: self.classroom ? self.classroom.name : "",
        classroom_number: self.classroom_number.nil? ? "" : self.classroom_number,
        student_number: self.student_number,
        gender_id: self.gender.nil? ? "" : I18n.t(self.gender.name),
        birthdate: self.birthdate.nil? ? "" : self.birthdate.strftime('%d/%m/%Y'),
        id: self.id
      }


    elsif options['autocomplete']
      return {
        id: self.id,
        img_url: self.img_medium,
        full_name_label: invoice_screen_student_number_display
      }
    elsif options['roll_call']
      roll_call_json = {
        id: self.id,
        code: self.code,
        first_name: self.first_name,
        last_name: self.last_name,
        prefix: self.prefix,
        number: self.number
      }

      return roll_call_json.merge(super())
    else
      super()
    end
  end

end
