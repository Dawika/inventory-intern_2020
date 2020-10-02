class AddInventoryType < ActiveRecord::Migration[5.0]
  def change
    add_column :inventories, :inventory_type, :string
  end
end
