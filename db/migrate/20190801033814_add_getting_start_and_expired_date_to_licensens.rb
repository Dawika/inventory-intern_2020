class AddGettingStartAndExpiredDateToLicensens < ActiveRecord::Migration[5.0]
  def change
    add_column :licenses, :getting_start, :datetime
    add_column :licenses, :expired_date, :datetime
    add_column :licenses, :status, :boolean, default: false
  end
end
