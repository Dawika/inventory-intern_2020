class Plan < ApplicationRecord
  
  scope :monthly, -> { where(frequency: 'monthly').first }
  scope :yearly, -> { where(frequency: 'yearly').first }
  has_many :license

  def monthly?
    self == Plan.monthly
  end
end
