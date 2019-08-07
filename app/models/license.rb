class License < ApplicationRecord
  belongs_to :school
  belongs_to :plan    
  has_one :charge_info
  before_create :add_expired_date

  def add_expired_date
    if school.licenses.empty?
      date = Time.zone.now + 3.month
      self.getting_start = date
      if plan.frequency == 'yearly'
        self.expired_date = date + 1.year
      elsif plan.frequency == 'monthly'
        self.expired_date = date + 1.month
      end
    else
      date = Time.zone.now
      self.getting_start = date
      if plan.frequency == 'yearly'
        self.expired_date = date + 1.year
      elsif plan.frequency == 'monthly'
        self.expired_date = date + 1.month
      end
    end
  end
end