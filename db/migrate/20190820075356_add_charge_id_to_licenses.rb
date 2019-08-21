class AddChargeIdToLicenses < ActiveRecord::Migration[5.0]
  def change
    add_column :licenses, :charge_id, :string
  end
end
