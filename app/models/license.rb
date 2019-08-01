class License < ApplicationRecord
    belongs_to :school
    belongs_to :plan
    belongs_to :payment_method_school
    
end