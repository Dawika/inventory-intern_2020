class ChangeColumnName < ActiveRecord::Migration[5.0]
  def up
    remove_column :student_illnesses, :type
    remove_column :addresses, :type
  end
end
