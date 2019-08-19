class AddRenewalReminderSentToLicenses < ActiveRecord::Migration[5.0]
  def change
    add_column :licenses, :renewal_reminder_sent, :bool, default: false
  end
end
