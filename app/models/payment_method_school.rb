class PaymentMethodSchool < ApplicationRecord
    has_one :school
    has_many :licenses
    validates :cardholder_name, :card_number, :exp_month, :exp_year,
    :cvv, :name, :address, :district, :province, :zip_code, :phone, presence: true
end