class Employee < ApplicationRecord
  include ActiveModel::Dirty
  rolify
  # Include default devise modules. Others available are:
  # :registerable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable,:recoverable, :rememberable, :trackable #, :validatable

  belongs_to :school
  has_many :emergency_calls, class_name: "Individual", foreign_key: 'emergency_call_id'
  has_many :spouses, class_name: "Individual", foreign_key: 'spouse_id'
  has_many :childs, class_name: "Individual", foreign_key: 'child_id'
  has_many :parents, class_name: "Individual", foreign_key: 'parent_id'
  has_many :friends, class_name: "Individual", foreign_key: 'friend_id'
  belongs_to :grade
  belongs_to :classroom
  has_many :teacher_attendance_lists
  has_many :employee_skills, dependent: :destroy
  has_many :employees, through: :employee_skills
  has_many :inventories
  has_many :inventory_requests
  has_many :inventory_repairs
  has_many :vacations, foreign_key: 'requester_id'
  has_one :taxReduction

  has_many :payrolls
  after_create :create_tax_reduction
  before_create :new_payroll
  after_save :update_rollcall_list
  before_save :assign_pin
  after_destroy :delete_payroll

  acts_as_paranoid

  has_attached_file :img_url
  validates_attachment_content_type :img_url, content_type: /\Aimage\/.*\z/

  def approver?
    self.has_role? :approver
  end

  def assign_pin
    self.pin = get_unique_pin if !pin
  end

  def update_rollcall_list
    if self.classroom_id && self.classroom_id_changed?
      # add or update list
      self.teacher_attendance_lists.destroy_all
      generate_teacher_attendance_lists
    else
      # remove list
      self.teacher_attendance_lists.destroy_all
    end
  end

  def has_last_salary
    has_last_closed_payroll = self.payrolls.size > 0 && self.last_closed_payroll
    {
      salary: (has_last_closed_payroll ? self.last_closed_payroll.salary.to_f : 0) > 0
    }
  end

  def last_closed_payroll
    self.payrolls.order(effective_date: :desc).first
  end

  def new_payroll
    self.payrolls << Payroll.new({ employee: self })
  end

  def full_name_or_id
    if !self.first_name.blank? && !self.last_name.blank?
      [self.prefix, self.first_name, self.middle_name, self.last_name].join(" ")
    else
      "Employee" + self.id.to_s
    end
  end

  def delete_payroll
    Payroll.where(employee_id: self.id, closed: [false, nil]).destroy_all
  end

  def full_name
    if I18n.locale == :en
      unless self.first_name.blank? && self.last_name.blank?
        [self.prefix, self.first_name, self.last_name].join(" ")
      else
        [self.prefix_thai, self.first_name_thai, self.last_name_thai].join(" ")
      end
    else
      unless self.first_name_thai.blank? && self.last_name_thai.blank?
        [self.prefix_thai, self.first_name_thai, self.last_name_thai].join(" ")
      else
        [self.prefix, self.first_name, self.last_name].join(" ")
      end
    end
  end

  def full_name_or_id
    if !self.first_name.blank? && !self.last_name.blank?
      [self.prefix, self.first_name, self.middle_name, self.last_name].join(" ")
    else
      "Employee" + self.id.to_s
    end
  end

  def full_name_with_nickname
    if self.nickname
      return self.full_name + " (#{self.nickname})"
    else
      return self.full_name
    end
  end

  def lists
    list_ids = TeacherAttendanceList.where(employee_id: self.id).pluck(:list_id).to_a
    return List.where(id: list_ids).to_a
  end

  def annual_income_outcome(id)
    employee = Employee.with_deleted.find(id)

    year = if employee.last_closed_payroll && employee.last_closed_payroll.effective_date
      employee.last_closed_payroll.effective_date.year
    else
      DateTime.now.year
    end
    start_year = Date.new(year, 1, 1)
    end_year = Date.new(year, 12, 31)

    payrolls = employee.payrolls.where(effective_date: start_year.beginning_of_day..end_year.end_of_day)

    return {
      total_salary: payrolls.as_json("report").inject(0) {
        |mem, var| mem + var[:salary] + var[:extra_pay]
      },
      total_tax: payrolls.sum(:tax),
      total_social_insurance: payrolls.sum(:social_insurance),
      total_aid_fund: payrolls.sum(:pvf)
    }
  end

  def as_json(options={})
    if options[:slip]
      result = {
        code: format("%05d", self.id),
        prefix: self.prefix,
        name: self.full_name,
        position: self.position,
        account_number: self.account_number,
        personal_id: self.personal_id,
        annual_income_outcome: self.annual_income_outcome(self.id)
      }

      # select payroll by payroll_id
      payroll = self.payroll(options[:payroll_id])
      if payroll
        result[:payroll] = payroll.as_json("slip")
        result[:extra_fee] = payroll.extra_fee.to_f
        result[:extra_pay] = payroll.extra_pay.to_f + payroll.salary.to_f
      else
        # default payroll
        result[:payroll] = self.last_closed_payroll.as_json("slip")
        result[:extra_fee] = self.last_closed_payroll.extra_fee.to_f
        result[:extra_pay] = self.last_closed_payroll.extra_pay.to_f + self.last_closed_payroll.salary.to_f
      end
      return result
    elsif options[:employee_list]
      has_last_closed_payroll = self.payrolls.size > 0 && self.last_closed_payroll
      {
        id: self.id,
        name: self.full_name,
        position: self.position,
        salary: has_last_closed_payroll ? self.last_closed_payroll.salary.to_f : 0,
        extra_fee: has_last_closed_payroll ? self.last_closed_payroll.extra_fee.to_f : 0,
        extra_pay: has_last_closed_payroll ? self.last_closed_payroll.extra_pay.to_f : 0,
        img: self.img_url.exists? ? self.img_url.expiring_url(10, :medium) : nil,
        deleted_at: self.deleted_at
      }
    else
      super()
    end
  end

  def lastest_payroll
     Payroll.where({ employee_id: self.id }).order(effective_date: :desc).first
  end

  def payroll(payroll_id)
    Payroll.where(employee_id: self.id, id: payroll_id).first
  end

  def tax_reduction
    TaxReduction.where(employee_id: self.id).first
  end

  def generate_teacher_attendance_lists
    if self.classroom
      TeacherAttendanceList.transaction do
        list = List.where(name: self.classroom.name).first
        if !list
          list = List.create(name: self.classroom.name, category: "roll_call")
          Student.where(classroom_id: self.classroom.id).pluck(:id).each do |student_id|
            StudentList.create(student_id: student_id, list_id: list.id)
          end
        else
          student_ids = Student.where(classroom_id: self.classroom.id).pluck(:id)
          exclude_student_ids = StudentList.where(list_id: list.id).pluck(:id)
          (student_ids - exclude_student_ids).each do |student_id|
            StudentList.create(student_id: student_id, list_id: list.id)
          end
        end

        if TeacherAttendanceList.where(employee_id: self.id, list_id: list.id).count == 0
          if TeacherAttendanceList.where(employee_id: self.id).count > 0
            TeacherAttendanceList.where(employee_id: self.id).destroy_all
          end
          TeacherAttendanceList.create(employee_id: self.id, list_id: list.id)
        end
      end
    end
  end

  def get_unique_pin
    pins = Employee.where.not(pin: nil).pluck(:pin).collect{|s| s.to_i}
    self.pin = ([*0..9999] - pins).sample.to_s.rjust(4, '0')
  end

  def self.split_name(name)
    name_obj = {
      prefix: '',
      first_name: '',
      middle_name: '',
      last_name: '',
      prefix_thai: '',
      first_name_thai: '',
      last_name_thai: ''
    }
    splited = name.split(" ")
    if (/[a-zA-Z]/ =~ name) != nil
      # english name
      if ["mr.", "ms.", "mrs.", "miss"].include?(splited[0].downcase)
        # has prefix
        name_obj[:prefix] = splited[0]
        if splited.length > 3
          # has middle_name
          name_obj[:first_name] = splited[1]
          name_obj[:middle_name] = splited[2]
          name_obj[:last_name] = splited[3]
        else
          name_obj[:first_name] = splited[1] if splited.length > 1
          name_obj[:last_name] = splited[2] if splited.length > 2
        end
      else
        if splited.length > 2
          # has middle_name
          name_obj[:first_name] = splited[0]
          name_obj[:middle_name] = splited[1]
          name_obj[:last_name] = splited[2]
        else
          name_obj[:first_name] = splited[0] if splited.length > 0
          name_obj[:last_name] = splited[1] if splited.length > 1
        end
      end
    else
      # thai name
      if ["นาย", "นาง", "นางสาว"].include?(splited[0])
        # has prefix_thai
        name_obj[:prefix_thai] = splited[0] if splited.length > 0
        name_obj[:first_name_thai] = splited[1] if splited.length > 1
        name_obj[:last_name_thai] = splited[2] if splited.length > 2
      else
        name_obj[:first_name_thai] = splited[0] if splited.length > 0
        name_obj[:last_name_thai] = splited[1] if splited.length > 1
      end
    end
    return name_obj
  end

  def leave_remaining
    vacation_setting = VacationSetting.where(school_id: self.school_id).first
    vacations = self.vacations.this_year
    sick_leave_count = vacations.sick_leave.map(&:deduce_days).inject(0, &:+)
    full_day_leave_count = vacations.vacation_full_day.not_rejected.map(&:deduce_days).inject(0, &:+)
    half_day_morning_leave_count = vacations.vacation_half_day_morning.not_rejected.map(&:deduce_days).inject(0, &:+)
    half_day_afternoon_leave_count = vacations.vacation_half_day_afternoon.not_rejected.map(&:deduce_days).inject(0, &:+)
    switch_date_count = vacations.switch_date.map(&:deduce_days).inject(0, &:+)
    work_at_home_count = vacations.work_at_home.map(&:deduce_days).inject(0, &:+)

    max_leave = (!self.sick_leave_maximum_days_per_year.nil?) ? self.sick_leave_maximum_days_per_year : vacation_setting.sick_leave_maximum_days_per_year
    max_leave += (!self.personal_leave_maximum_days_per_year.nil?) ? self.personal_leave_maximum_days_per_year : vacation_setting.personal_leave_maximum_days_per_year

    deduce_days = 0
    deduce_days += sick_leave_count
    deduce_days += full_day_leave_count
    deduce_days += half_day_morning_leave_count
    deduce_days += half_day_afternoon_leave_count
    deduce_days += switch_date_count
    deduce_days += work_at_home_count
    remaining_day = max_leave - deduce_days

    i, f = remaining_day.to_i, remaining_day.to_f
    i == f ? i : f
  end

  def sick_leave_remaining
    vacation_setting = VacationSetting.where(school_id: self.school_id).first
    vacations = self.vacations.this_year
    sick_leave_count = vacations.sick_leave.map(&:deduce_days).inject(0, &:+)

    max_leave = (!self.sick_leave_maximum_days_per_year.nil?) ? self.sick_leave_maximum_days_per_year : vacation_setting.sick_leave_maximum_days_per_year

    deduce_days = 0
    deduce_days += sick_leave_count
    remaining_day = max_leave - deduce_days

    i, f = remaining_day.to_i, remaining_day.to_f
    i == f ? i : f
  end

  def personal_leave_remaining
    vacation_setting = VacationSetting.where(school_id: self.school_id).first
    vacations = self.vacations.this_year
    full_day_leave_count = vacations.vacation_full_day.not_rejected.map(&:deduce_days).inject(0, &:+)
    half_day_morning_leave_count = vacations.vacation_half_day_morning.not_rejected.map(&:deduce_days).inject(0, &:+)
    half_day_afternoon_leave_count = vacations.vacation_half_day_afternoon.not_rejected.map(&:deduce_days).inject(0, &:+)

    max_leave = (!self.personal_leave_maximum_days_per_year.nil?) ? self.personal_leave_maximum_days_per_year : vacation_setting.personal_leave_maximum_days_per_year

    deduce_days = 0
    deduce_days += full_day_leave_count
    deduce_days += half_day_morning_leave_count
    deduce_days += half_day_afternoon_leave_count
    remaining_day = max_leave - deduce_days

    i, f = remaining_day.to_i, remaining_day.to_f
    i == f ? i : f
  end

  def switch_day_remaining
    vacation_setting = VacationSetting.where(school_id: self.school_id).first
    vacations = self.vacations.this_year
    switch_date_count = vacations.switch_date.map(&:deduce_days).inject(0, &:+)

    max_leave = (!self.switching_day_maximum_days_per_year.nil?) ? self.switching_day_maximum_days_per_year : vacation_setting.switching_day_maximum_days_per_year

    deduce_days = 0
    deduce_days += switch_date_count
    remaining_day = max_leave - deduce_days

    i, f = remaining_day.to_i, remaining_day.to_f
    i == f ? i : f
  end

  def work_at_home_remaining
    vacations = self.vacations.this_year
    vacation_setting = VacationSetting.where(school_id: self.school_id).first
    work_at_home_count = vacations.work_at_home.map(&:deduce_days).inject(0, &:+)

    max_leave = (!self.work_at_home_maximum_days_per_week.nil?) ? self.work_at_home_maximum_days_per_week : vacation_setting.work_at_home_maximum_days_per_week

    deduce_days = 0
    deduce_days += work_at_home_count
    remaining_day = max_leave - deduce_days

    i, f = remaining_day.to_i, remaining_day.to_f
    i == f ? i : f
  end

  def maximum_leave
    vacation_setting = VacationSetting.where(school_id: self.school_id).first
    max_leave = (!self.sick_leave_maximum_days_per_year.nil?) ? self.sick_leave_maximum_days_per_year : vacation_setting.sick_leave_maximum_days_per_year
    max_leave += (!self.personal_leave_maximum_days_per_year.nil?) ? self.personal_leave_maximum_days_per_year : vacation_setting.personal_leave_maximum_days_per_year

    return max_leave
  end

  private
    def create_tax_reduction
      TaxReduction.create(employee_id: self.id)
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
      sheet = open_file(file_path).sheet('employees')
      sheet.each_with_index(
        identification_no: 'identification_no',
        position: 'position',
        gade_name: 'gade_name',
        classroom_name: 'classroom_name',
        prefix_th: 'prefix_th',
        first_name_th: 'first_name_th',
        last_name_th: 'last_name_th',
        prefix_en: 'prefix_en',
        first_name_en: 'first_name_en',
        middle_name_en: 'middle_name_en',
        last_name_en: 'last_name_en',
        nickname: 'nickname',
        status: 'status',
        birthday: 'birthday',
        email: 'email',
        phone: 'phone',
        start_working: 'start_working',
        address: 'address',
        passport_no: 'passport_no',
        nationality: 'nationality',
        race: 'race',
        bank_name: 'bank_name', 
        bank_branch: 'bank_branch',
        bank_account_number: 'bank_account_number',
        salary: 'salary',
        ot: 'ot',
        position_allowance: 'position_allowance',
        allowance: 'allowance',
        attendance_bonus: 'attendance_bonus',
        bonus: 'bonus',
        extra_etc: 'extra_etc'
      
      ) do |row, index|
          if index > 0 and ( row[:first_name_en].present? || row[:first_name_th].present? )
            employee = Employee.find_or_create_by(personal_id: row[:identification_no], school_id: school_id, email: row[:email] )
            employee.prefix = row[:prefix_en] || ""
            employee.first_name = row[:first_name_en] || ""
            employee.middle_name = row[:middle_name_en] || ""
            employee.last_name = row[:last_name_en] || ""
            employee.nickname = row[:nickname] || ""
            employee.prefix_thai  = row[:prefix_th] || ""
            employee.first_name_thai = row[:first_name_th] || ""
            employee.last_name_thai = row[:last_name_th] || ""
            employee.passport_number = row[:passport_no] || ""
            employee.nationality = row[:nationality] 
            employee.race = row[:race]
            employee.bank_name = row[:bank_name]
            employee.bank_branch = row[:bank_branch]
            employee.account_number = row[:bank_account_number]
            employee.email = row[:email]
            employee.school_id = school_id
            employee.position = row[:position]
            employee.birthdate = row[:birthday].present? ? row[:birthday].to_time : nil
            employee.tel = row[:phone]
            employee.start_date = row[:start_working].present? ? row[:start_working].to_time : nil
            employee.address = row[:address]
            employee.status = row[:status]
            grade = Grade.where(["name = ?", row[:gade_name].to_s])
            employee.grade_id = (grade != nil ? grade.ids[0] : 0)
            classroom = Classroom.where(["name = ?", row[:classroom_name].to_s])
            employee.classroom_id = (classroom != nil ? classroom.ids[0] : 0)
            # income
            payroll = employee.payrolls.first
            payroll.salary = row[:salary] || 0
            payroll.ot = row[:ot] || 0
            payroll.position_allowance = row[:position_allowance] || 0
            payroll.allowance = row[:allowance] || 0
            payroll.attendance_bonus = row[:attendance_bonus] || 0
            payroll.bonus = row[:bonus] || 0
            payroll.extra_etc = row[:extra_etc] || 0
            payroll.save
            employee.save!
          else
            not_save << index + 3 if index != 0
          end
      end
      return not_save
    end

end
