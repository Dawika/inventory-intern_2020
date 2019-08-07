class RemoveColumnInPaymentMethodSchool < ActiveRecord::Migration[5.0]
  def up
    remove_column :payment_method_schools, :payment_method
    remove_column :payment_method_schools, :cardholder_name
    remove_column :payment_method_schools, :card_number
    remove_column :payment_method_schools, :exp_month
    remove_column :payment_method_schools, :exp_year
    remove_column :payment_method_schools, :cvv
  end

  def down
    add_column :payment_method_schools, :payment_method, :string
    add_column :payment_method_schools, :cardholder_name, :string
    add_column :payment_method_schools, :card_number, :string
    add_column :payment_method_schools, :exp_month, :string
    add_column :payment_method_schools, :exp_year, :string
    add_column :payment_method_schools, :cvv, :integer
  end
end
