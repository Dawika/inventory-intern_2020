class Plan < ApplicationRecord
  
  scope :monthly, -> { where(frequency: 'monthly').first }
  scope :annually, -> { where(frequency: 'annually').first }
  has_many :license

  def monthly?
    self == Plan.monthly
  end
end
