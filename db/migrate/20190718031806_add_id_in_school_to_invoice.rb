class AddIdInSchoolToInvoice < ActiveRecord::Migration[5.0]
  def change
    add_column :invoices, :slip_id, :integer
  end
end
