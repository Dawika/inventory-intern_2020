class AddExpenseTabsOrderConfig < ActiveRecord::Migration[5.0]
  def change
    add_column :site_configs, :first_expense_tab, :string, default: 'upload_photo'
    add_column :school_settings, :first_expense_tab, :string, default: 'upload_photo'
  end
end
