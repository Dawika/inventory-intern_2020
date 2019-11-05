class AddForeignKeySchoolToPaymentMethodSchool < ActiveRecord::Migration[5.0]
  def change
    add_reference :payment_method_schools, :school, foreign_key: { to_table: :schools }
  end
end
