class RenamePaymentMethodSchoolsAndRemoveForeignKey < ActiveRecord::Migration[5.0]
  def up
    remove_reference :licenses, :payment_method_school, index: true, foreign_key: true
    rename_table :payment_method_schools, :bil_infos
  end

  def down
    rename_table :bil_infos, :payment_method_schools
    add_reference :licenses, :payment_method_school, foreign_key: {to_table: :payment_method_schools}
  end
end
