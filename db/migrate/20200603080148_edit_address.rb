class EditAddress < ActiveRecord::Migration[5.0]
  def up
    remove_column :parents, :is_living
    remove_column :parents, :average_salary
  end
end
