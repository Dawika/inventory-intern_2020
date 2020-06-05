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
    sheet = open_file(file_path).sheet('parents')
    sheet.each_with_index( 
      identificatio_no_child: 'identificatio_no_child',
      identificatio_no_parent: 'identificatio_no_parent',
      relationship: 'relationship',
      live_status: 'live_status',
      name_prefix: 'name_prefix',
      name: 'name',
      middle_name: 'middle_name',
      last_name: 'last_name',
      name_eng: 'name_eng',
      middle_name_eng: 'middle_name_eng',
      last_name_eng: 'last_name_eng',
      birthdate: 'birthdate',
      gender: 'gender',
      blood_type: 'blood_type',
      nationality: 'nationality',
      race: 'race',
      religion: 'religion',
      marital_status: 'marital_status',
      email: 'email',
      mobile: 'mobile',
      education: 'education',
      education_title: 'education_title',
      occupation: 'occupation',
      occupation_title: 'occupation_title',
      work_place: 'work_place',
      average_salary: 'average_salary',
      contact_house_no: 'contact_house_no',
      contact_house_title: 'contact_house_title',
      contact_alley: 'contact_alley',
      contact_road: 'contact_road',
      contact_sub_district: 'contact_sub_district',
      contact_district: 'contact_district',
      contact_province: 'contact_province',
      contact_postcode: 'contact_postcode',
      registered_house_no: 'registered_house_no',
      registered_house_title: 'registered_house_title',
      registered_alley: 'registered_alley',
      registered_road: 'registered_road',
      registered_sub_district: 'registered_sub_district',
      registered_district: 'registered_district',
      registered_province: 'registered_province',
      registered_postcode: 'registered_postcode'
      ) do |row,index|
      if index > 0
        parent = Parent.find_or_create_by(id_card_no: row[:identificatio_no_parent], email: row[:email])
        first_name = row[:name] != nil ? row[:name].strip : ''
        middle_name = row[:middle_name] != nil ? row[:middle_name].strip : ''
        last_name = row[:last_name] != nil ? row[:last_name].strip : ''

        first_name_eng = row[:name_eng] != nil ? row[:name_eng].strip : ''
        middle_name_eng = row[:middle_name_eng] != nil ? row[:middle_name_eng].strip : ''
        last_name_eng = row[:last_name_eng] != nil ? row[:last_name_eng].strip : ''

        full_name = middle_name != '' ? ("#{first_name} #{middle_name} #{last_name}") : ("#{first_name} #{last_name}")
        full_name_eng = middle_name != '' ? ("#{first_name_eng} #{middle_name_eng} #{last_name_eng}") : ("#{first_name_eng} #{last_name_eng}")

        parent.full_name = full_name
        parent.full_name_english = full_name_eng
        gender = Gender.where(["name = ? or name_th = ?",row[:gender].strip,row[:gender].strip])
        parent.gender_id = (gender != nil ? gender.ids[0] : 0)
        parent.birthdate = row[:birthdate]
        parent.relation = row[:relationship].strip
        parent.live_status = row[:live_status]
        parent.birthdate = row[:birthdate]
        parent.blood_type = row[:blood_type]
        parent.nationality = row[:nationality]
        parent.race = row[:race]
        parent.religion = row[:religion]
        parent.marital_status = row[:marital_status]
        parent.email = row[:email]
        parent.mobile = row[:mobile]
        parent.education = row[:education]
        parent.education_title = row[:education_title]
        parent.occupation = row[:occupation]
        parent.occupation_title = row[:occupation_title]
        parent.work_place = row[:work_place]
        parent.average_salary = row[:average_salary]
        parent.school_id = school_id
        parent.id_card_no = row[:identificatio_no_parent]
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

        if row[:email] != nil && row[:email] != ''

        contact_address = Address.where(reference_id: row[:email]).find_or_create_by(address_type: "Contact")

        contact_address.address_type = "Contact"
        contact_address.address_text = "#{row[:contact_house_title]} #{row[:contact_house_title]} #{row[:contact_alley]} #{row[:contact_road]}"
        contact_address.sub_district = row[:contact_sub_district]
        contact_address.district = row[:contact_district]
        contact_address.province = row[:contact_province]
        contact_address.postcode = row[:contact_postcode]
        contact_address.country = row[:contact_country]
        if row[:relationship] == 'บิดา'
          contact_address.reference = "Father"
        elsif row[:relationship] == 'มารดา'
          contact_address.reference = "Mother"
        else
          contact_address.reference = "Official"
        end
        contact_address.reference_id = row[:email]
        contact_address.save!
        
        registered_address = Address.where(reference_id: row[:email]).find_or_create_by(address_type: "Registered")

        registered_address.address_type = "Registered"
        registered_address.address_text = "#{row[:registered_house_title]} #{row[:registered_house_title]} #{row[:registered_alley]} #{row[:registered_road]}"
        registered_address.sub_district = row[:registered_sub_district]
        registered_address.district = row[:registered_district]
        registered_address.province = row[:registered_province]
        registered_address.postcode = row[:registered_postcode]
        registered_address.country = row[:registered_country]
        if row[:relationship] == 'บิดา'
          registered_address.reference = "Father"
        elsif row[:relationship] == 'มารดา'
          registered_address.reference = "Mother"
        else
          registered_address.reference = "Official"
        end
        registered_address.reference_id = row[:email]
        registered_address.save!
       end
      end
    end
  end
end
