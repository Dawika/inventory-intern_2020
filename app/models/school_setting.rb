class SchoolSetting < ApplicationRecord
  @@default_semesters = ["1","2","3"]

  validates :school_year, presence: true

  after_save :clear_config_cache, :regenerate_tax

  belongs_to :school

  def regenerate_tax
    if self.tax_changed?
      self.school.payrolls.where(closed: [nil, false]).each do |payroll|
        payroll.generate_tax!
      end
    end
  end

  def self.school_year
    school_setting = SchoolSetting.first
    school_setting ? school_setting.school_year : Time.current.year + 543
  end

  def self.get_cache(subdomain)
    return Rails.cache.fetch("school_setting_#{subdomain}".to_sym) do
      school = School.find_by_subdomain_name(subdomain)
      return school ? school.school_setting : nil
    end
  end

  def school_year
    self[:school_year] ? self[:school_year] : Time.current.year + 543
  end

  def self.school_year_or_default(default)
    school_setting = SchoolSetting.first
    school_setting ? school_setting.school_year_or_default(default) : default
  end

  def school_year_or_default(default)
    self[:school_year] ? self[:school_year] : default
  end

  def self.semesters
    school_setting = SchoolSetting.first
    school_setting ? school_setting.semesters : @@default_semesters
  end

  def semesters
    school_setting = SchoolSetting.first
    self[:semesters] ? self[:semesters].split(",") : @@default_semesters
  end

  def self.current_semester
    school_setting = SchoolSetting.first
    school_setting ? school_setting.current_semester : @@default_semesters[0]
  end

  def current_semester
    school_setting = SchoolSetting.first
    self[:current_semester] ? self[:current_semester] : school_setting.semesters[0]
  end

  private
  def clear_config_cache
    Rails.cache.delete("school_setting_#{school.subdomain_name}".to_sym)
  end
end
