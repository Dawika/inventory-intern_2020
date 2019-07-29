class PaymentMethodSchool < ApplicationRecord
    has_one :school
    has_many :licenses
end