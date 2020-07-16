class AddTotalToLineItem < ActiveRecord::Migration[5.0]
  def up
    add_column :line_items, :total_price, :float
    add_column :line_items, :item_amount, :integer
    add_column :line_items, :school_id, :integer
    add_column :line_item_quotations, :total_price, :float
    add_column :line_item_quotations, :item_amount, :integer
    add_column :line_item_quotations, :school_id, :integer
  end

  def down
    remove_column :line_items, :total_price
    remove_column :line_items, :item_amount
    remove_column :line_items, :school_id
    remove_column :line_item_quotations, :total_price
    remove_column :line_item_quotations, :item_amount
    remove_column :line_item_quotations, :school_id
  end
end
