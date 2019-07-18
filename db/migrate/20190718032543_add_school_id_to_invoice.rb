class AddSchoolIdToInvoice < ActiveRecord::Migration[5.0]
  def change
    add_reference :invoices, :school, foreign_key: { to_table: :schools }
  end
end
