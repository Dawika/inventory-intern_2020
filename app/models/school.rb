class School < ApplicationRecord
  has_many :employees
  has_many :payrolls, through: :employees
  has_many :users
  has_many :school_settings
  has_many :students
  has_many :parents
  has_many :invoices
  has_many :expense_tags
  has_many :licenses
  has_one :bil_info
  belongs_to :plan
  has_many :grades
  has_attached_file :logo, styles: { medium: "200x200>", thumb: "100x100>" }, default_url: "new_somsri_logo2.png"
  validates_attachment_content_type :logo, content_type: ["image/jpeg", "image/jpg", "image/png"]
  accepts_nested_attributes_for :users
  accepts_nested_attributes_for :school_settings
  accepts_nested_attributes_for :bil_info
  accepts_nested_attributes_for :licenses
  validates :name, :address, :name_eng, :phone, :logo, presence: true, allow_blank: false
  validates :email, presence: true, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :subdomain_name, presence: true, allow_blank: false, uniqueness: true
  attr_accessor :grades_name

  after_create :create_license

  def create_grades(data) 
    if data.present?
      if data.dig(:pre_school).present?
        self.grades.create(name: "Pre School", school_id: self.id)
      end 
      if data.dig(:kindergarten).present? 
        (1..3).each do |i|
          self.grades.create(name: "Kindergarten #{i}", school_id: self.id)
        end
      end
      if data.dig(:primary_school).present? 
        (1..6).each do |i|
          self.grades.create(name: "Primary School #{i}", school_id: self.id)
        end
      end  
      if data.dig(:junior_high_school).present? 
        (1..3).each do |i|
          self.grades.create(name: "Junior High School #{i}", school_id: self.id)
        end
      end  
      if data.dig(:senior_high_school).present? 
        (1..3).each do |i|
          self.grades.create(name: "Senior High School #{i}", school_id: self.id)
        end
      end 
      if data.dig(:voc_cert).present? 
        self.grades.create(name: "Vocational Certificate (Voc. Cert.)", school_id: self.id)
      end 
      if data.dig(:dip_high_voc_cert).present? 
        self.grades.create(name: "High Vocational Certificate (High Voc. Cert.)", school_id: self.id)
      end 
      if data.dig(:other).present? 
        self.grades.create(name: "Other", school_id: self.id)
      end 
    end 
  end

  def school_setting
    school_settings.first || SiteConfig.get_cache
  end

  def create_license
      self.licenses.create(expired_date: DateTime.now.utc + 4.month)
  end

  def default_card
    customer = self.customer_info
    return nil if customer.blank?
    customer.default_card
  end

  def customer_info #info credit card
    return nil if self.customer_id.blank?

    (Omise::Customer.retrieve(self.customer_id) rescue nil)
  end

  def active_license
      licenses.first
  end

  def logo_url
    self.logo.expiring_url(3600, :medium)
  end

  def daily_report_header_with_logo
    if self.daily_report_header.present? && self.logo_url.present?
      return self.daily_report_header.gsub("_LOGO_URL_", self.logo_url)
    end
    return self.daily_report_header
  end

  def invoice_header_with_logo
    if self.invoice_header.present? && self.logo_url.present?
      return self.invoice_header.gsub("_LOGO_URL_", self.logo_url)
    end
    return self.invoice_header
  end

  def payroll_slip_header_with_logo
    if self.payroll_slip_header.present? && self.logo_url.present?
      return self.payroll_slip_header.gsub("_LOGO_URL_", self.logo_url)
    end
    return self.payroll_slip_header
  end

  def user
    self.users.first
  end
end
