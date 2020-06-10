class AddIndexSortingToGrade < ActiveRecord::Migration[5.0]
  def up
    add_column :grades, :index_sorting, :integer 
  end

  def down
    remove_column :grades, :index_sorting, :integer
  end
end
