class AddDailyReportToInvoice < ActiveRecord::Migration[5.0]
  def up
    add_column :invoices, :status_daily_report, :boolean, default: false
  end

  def down
    remove_column :invoices, :status_daily_report
  end
end
