class AddParentsColumn < ActiveRecord::Migration[5.0]
  def change
    add_column :parents, :live_status, :string
    add_column :parents, :average_salary, :string
  end
end
