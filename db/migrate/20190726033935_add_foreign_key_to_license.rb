class AddForeignKeyToLicense < ActiveRecord::Migration[5.0]
  def change
    add_reference :licenses, :school, foreign_key: { to_table: :schools }
    add_reference :licenses, :plan, foreign_key: { to_table: :plans }
  end
end
