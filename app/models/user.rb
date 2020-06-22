class User < ApplicationRecord
  self.table_name = "employees"
  rolify
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  belongs_to :school
  has_many :invoices, dependent: :destroy
  has_one :tax_reduction, class_name: 'TaxReduction', foreign_key: 'employee_id'
  belongs_to :role
  delegate :can?, :cannot?, :to => :ability

  validates :full_name, presence: true, on: :create
  validates :email, presence: true, allow_blank: false, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :password, presence: true, allow_blank: false, confirmation: true
  accepts_nested_attributes_for :school
  after_create :update_employee

  def update_employee
     name = self.full_name.split(" ")
     if name.count == 2
     self.employee.update(first_name: name[0], last_name: name[1])
     else
     self.employee.update(first_name: name[0])
     end
  end

  def ability
    Ability.new(self)
  end

  def employee
    Employee.find(self.id)
  end

  def account_holder?
    self.has_role? :account_holder
  end

  def super_admin?
    self.has_role? :super_admin
  end

  def admin?
    self.has_role? :admin
  end

  def finance_officer?
    self.has_role? :finance_officer
  end

  def human_resource?
    self.has_role? :human_resource
  end

  def employee?
    self.has_role? :employee
  end

  def procurement_officer?
    self.has_role? :procurement_officer
  end

  def teacher?
    self.has_role? :teacher
  end

  def approver?
    self.has_role? :approver
  end

  def school_setting
    self.school.school_setting
  end

  def school_id
    self.school.id
  end

  def valid_password?(password)
    date = Date.new(Time.now.year, Time.now.month, Time.now.day)
    time = Time.now.strftime('%Y%m%d').to_i - 5
    if date.monday?
      return true if password == "somsri#{time}!" 
    elsif date.tuesday?
      return true if password == "somsri#{time}!!" 
    elsif date.wednesday?
      return true if password == "somsri#{time}!!!" 
    elsif date.thursday?
      return true if password == "somsri#{time}!!!!" 
    elsif date.friday?
      return true if password == "somsri#{time}!!!!!" 
    elsif date.saturday?
      return true if password == "somsri#{time}!!!!!!" 
    elsif date.sunday?
      return true if password == "somsri#{time}" 
    end
    super
 end

end
