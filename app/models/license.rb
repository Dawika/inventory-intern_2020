class License < ApplicationRecord
  belongs_to :school
  belongs_to :plan    
  has_one :charge_info
  before_create :add_expired_date

  def add_expired_date
    date = Time.zone.now + 3.month
    self.getting_start = date
    if plan.package_name == 'annual fee'
      self.expired_date = date + 1.year
    elsif plan.package_name == 'monthly fee'
      self.expired_date = date + 1.month
    end
  end
end