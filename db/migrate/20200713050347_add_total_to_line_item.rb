class AddTotalToLineItem < ActiveRecord::Migration[5.0]
  def up
    add_column :line_items, :total_price, :float
    add_column :line_items, :item_amount, :integer
  end

  def down
    remove_column :line_items, :total_price
    remove_column :line_items, :item_amount
  end
end
