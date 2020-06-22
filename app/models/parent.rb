class Parent < ApplicationRecord
  include StudentsHelper
  include Rails.application.routes.url_helpers

  has_many :students_parents, dependent: :destroy
  has_and_belongs_to_many :students, join_table: "students_parents"
  has_and_belongs_to_many :relationships, join_table: "students_parents"
  has_many :invoices, -> { with_deleted }
  belongs_to :school, -> { with_deleted }
  default_scope { where(school_id: CurrentUser.first.current_user) }

  acts_as_paranoid

  has_attached_file :img_url
  validates_attachment_content_type :img_url, content_type: /\Aimage\/.*\z/

  self.per_page = 10
  before_save :clean_full_name

  def clean_full_name
    self.full_name = self.full_name.strip.gsub(/\s+/,' ') if self.full_name
  end

  def self.search(search)
    Parent.joins(:students).where("parents.full_name LIKE ? OR parents.full_name_english LIKE ? OR parents.email LIKE ? OR parents.mobile LIKE ? OR students.full_name LIKE ? OR students.full_name_english LIKE ?", "%#{search}%", "%#{search}%", "%#{search}%", "%#{search}%", "%#{search}%" , "%#{search}%" )
  end

  def self.search_by_name_and_mobile(search)
    Parent.where("parents.full_name LIKE ? OR parents.full_name_english LIKE ? OR parents.mobile LIKE ?", "%#{search}%", "%#{search}%", "%#{search}%")
  end

  def invoice_screen_full_name_display
    if(mobile.to_s.strip != '')
      full_name + ' (' + mobile.to_s.strip + ')'
    else
      full_name
    end
  end

  def edit
    ActionController::Base.helpers.link_to I18n.t('.edit', :default => '<i class="fa fa-pencil-square-o" aria-hidden="true"></i> แก้ไข'.html_safe), edit_parent_path(self), :class => 'btn-edit-student-parent'
  end

  def relationship_names
    if self.respond_to?("name")
      self.name.nil? ? "" : I18n.t(self.name)
    else
      self.relationships.first.nil? ? "" : I18n.t(self.relationships.first.name)
    end
  end

  def studentFullname
    if self.respond_to?("student_name")
      self.student_name.nil? ? student_link(self.students.first) : student_link_by_hash(self.student_name.empty? ? Student.find_by(id: self.student_id)&.full_name_english : self.student_name, self.student_id)
    else
      student_link(self.students.first)
    end
  end

  def self.restore_by_student_id(student_id)
    parent_ids = StudentsParent.where(student_id: student_id).to_a.collect(&:parent_id)
    Parent.with_deleted.where(id: parent_ids).all.each do |parent|
      parent.restore_recursively
    end
  end

  def restore_recursively
    Parent.transaction do
      # restore all destroy by dependent: :destroy
      self.restore(recursive: true, recovery_window: 2.minutes)
    end
  end

  def as_json(options={})
    if options[:index]
      return {
        parents:{
          id: self.id,
          img_url: self.img_url.exists? ? self.img_url.expiring_url(10, :medium) : '',
          full_name: self.full_name,
          mobile: self.mobile,
          email: self.email,
        },
        relationships: {
          name: relationship_names
        },
        students: {
          full_name: studentFullname.nil? ? "" : studentFullname
        },
        edit: edit
      }
    elsif options[:autocomplete]
      return {
        full_name_label: self.invoice_screen_full_name_display,
        img_url: self.img_url.exists? ? self.img_url.expiring_url(10, :medium) : '',
        id: self.id
      }
    else
      super()
    end
  end

  def self.open_file(file)
    case File.extname(file.original_filename)
  	when ".csv" then Roo::Csv.new(file.path, options={})
  	when ".xls" then Roo::Excel.new(file.path, options={})
  	when ".xlsx" then Roo::Excelx.new(file.path, options={})
  	else raise "Unknown file type: #{file.original_filename}"
  	end
  end


  def self.import(file_path, school_id)
    not_save = []
    sheet = open_file(file_path).sheet('parents')
    sheet.each_with_index( 
      identificatio_no_child: 'identificatio_no_child',
      identificatio_no_parent: 'identificatio_no_parent',
      relationship: 'relationship',
      name_prefix: 'name_prefix',
      name: 'name',
      middle_name: 'middle_name',
      last_name: 'last_name',
      nickname: 'nickname',
      name_eng: 'name_eng',
      middle_name_eng: 'middle_name_eng',
      last_name_eng: 'last_name_eng',
      nickname_eng: 'nickname_eng',
      gender: 'gender',
      email: 'email',
      mobile: 'mobile',
      line_id: 'line_id'
      ) do |row,index|
      if index > 0 and (row[:name].present? || row[:name_eng])
        parent = Parent.find_or_create_by(id_card_no: row[:identificatio_no_parent], email: row[:email])
        first_name = row[:name] != nil ? row[:name].to_s.strip : ''
        middle_name = row[:middle_name] != nil ? row[:middle_name].to_s.strip : ''
        last_name = row[:last_name] != nil ? row[:last_name].to_s.strip : ''

        first_name_eng = row[:name_eng] != nil ? row[:name_eng].to_s.strip : ''
        middle_name_eng = row[:middle_name_eng] != nil ? row[:middle_name_eng].to_s.strip : ''
        last_name_eng = row[:last_name_eng] != nil ? row[:last_name_eng].to_s.strip : ''

        full_name = middle_name != '' ? ("#{first_name} #{middle_name} #{last_name}") : ("#{first_name} #{last_name}")
        full_name_eng = middle_name != '' ? ("#{first_name_eng} #{middle_name_eng} #{last_name_eng}") : ("#{first_name_eng} #{last_name_eng}")

        parent.full_name = full_name
        parent.full_name_english = full_name_eng
        gender = Gender.where(["name = ? or name_th = ?",row[:gender].to_s.strip,row[:gender].to_s.strip])
        parent.gender_id = (gender != nil ? gender.ids[0] : 0)
        parent.email = row[:email]
        parent.mobile = row[:mobile]
        parent.nickname = row[:nickname]
        parent.nickname_english = row[:nickname_eng]
        parent.school_id = school_id
        parent.relation = row[:relationship]
        parent.id_card_no = row[:identificatio_no_parent]
        parent.line_id = row[:line_id]
        parent.save!

        students = Student.where(national_id: row[:identificatio_no_child])
        if students != nil && students.count > 0
          students.each do |student|
            relationship_mapping = StudentsParent.where(student_id: student.id).find_or_create_by(parent_id: parent.id)
            relationship_mapping.student_id = student.id
            relationship_mapping.parent_id = parent.id
            parent.relation.present? ? Relationship.where(name_th: parent.relation).collect {|d| relationship_mapping.relationship_id =  d.id} : 0
            relationship_mapping.save!
          end
        end
      else
        not_save << index + 3 if index != 0
      end
    end
   return not_save
  end

end
