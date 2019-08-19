class License < ApplicationRecord
  default_scope { order('created_at desc') }

  belongs_to :school
  belongs_to :plan    
  has_one :charge_info
end