class School < ApplicationRecord
  has_many :employees
  has_many :payrolls, through: :employees
  has_many :users
  has_many :school_settings
  has_many :students
  has_many :parents
  has_many :invoices
  has_many :licenses
  has_one :bil_info
  belongs_to :plan
  has_attached_file :logo, styles: { medium: "200x200>", thumb: "100x100>" }, default_url: "/somsri_logo.png"
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

  def school_setting
    school_settings.first || SiteConfig.get_cache
  end

  def create_license
      self.licenses.create(expired_date: DateTime.now.utc + 3.month)
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
