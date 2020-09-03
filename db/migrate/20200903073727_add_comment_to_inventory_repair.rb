class AddCommentToInventoryRepair < ActiveRecord::Migration[5.0]
  def change
    add_column :inventory_repairs, :comment, :string
  end
end
