class AddForeignKeyPaymentSchoolToLicense < ActiveRecord::Migration[5.0]
  def change
    add_reference :licenses, :payment_method_school, foreign_key: {to_table: :payment_method_schools}
  end
end
