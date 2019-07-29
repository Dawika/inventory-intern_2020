class AddForeignKeyToPaymentMethodSchool < ActiveRecord::Migration[5.0]
  def change
    add_reference :payment_method_schools, :license, foreign_key: {  to_table: :licenses }
  end
end
