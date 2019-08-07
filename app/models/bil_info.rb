class BilInfo < ApplicationRecord
    has_one :school
    attr_accessor :check, :payment_method, :cardholder_name, :card_number, :exp_month, :exp_year, :cvv
    validates :payment_method, :cardholder_name, :card_number, :exp_month, :exp_year, :cvv, presence: true, if: :transfer_money
    validates :name, :address, :district, :province, :zip_code, :phone, :tax_id, :branch, presence: true

    def transfer_money
        check == "true"
    end
end