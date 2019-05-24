class AddForeignKeyToSchools < ActiveRecord::Migration[5.0]
  def change
    add_reference :schools, :school_setting, foreign_key: { to_table: :school_settings }
  end
end
