class AddForeignKeyToSchools < ActiveRecord::Migration[5.0]
  def change
    add_reference :school_settings, :school, foreign_key: { to_table: :schools }
  end
end
