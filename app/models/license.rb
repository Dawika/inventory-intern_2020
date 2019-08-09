class License < ApplicationRecord
  belongs_to :school
  belongs_to :plan    
  has_one :charge_info
end