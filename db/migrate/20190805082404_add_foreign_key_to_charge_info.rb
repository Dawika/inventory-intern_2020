class AddForeignKeyToChargeInfo < ActiveRecord::Migration[5.0]
  def change
    add_reference :charge_infos, :license, foreign_key: {to_table: :licenses}
  end
end
