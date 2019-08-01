class PaymentMethodSchool < ApplicationRecord
    has_one :school
    has_many :licenses
    attr_accessor :check
    validates :cardholder_name, :card_number, :exp_month, :exp_year,
    :cvv, presence: true, if: :transfer_money 
    validates :name, :address, :district, :province, :zip_code, :phone, :tax_id, presence: true

    def transfer_money
      check.present? 
    end
end