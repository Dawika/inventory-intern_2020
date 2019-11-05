class RemoveColumnGettingStartInLicenses < ActiveRecord::Migration[5.0]
  def up
    remove_column :licenses, :getting_start
    remove_column :licenses, :status
    remove_reference :bil_infos, :license, index: true, foreign_key: true
  end

  def down
    add_column :licenses, :getting_start, :datetime  
    add_column :licenses, :status, :boolean, default: false
    add_reference :bil_infos, :license, foreign_key: {to_table: :licenses}
  end
end
