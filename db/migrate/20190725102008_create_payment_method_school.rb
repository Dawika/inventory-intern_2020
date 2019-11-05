class CreatePaymentMethodSchool < ActiveRecord::Migration[5.0]
  def change
    create_table :payment_method_schools do |t|
      t.string :payment_method
      t.string :cardholder_name
      t.string :card_number
      t.string :exp_month
      t.string :exp_year
      t.integer :cvv
      t.string :name
      t.string :address
      t.string :district
      t.string :province
      t.string :zip_code
      t.string :phone
      t.string :tax_id
      t.string :branch
    end
  end
end
