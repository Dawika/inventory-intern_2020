class CreateAutoLineItem < ActiveRecord::Migration[5.0]
  def up
    create_table :auto_line_items do |t|
      t.string :name
      t.float :price
      t.integer :amount, default: 1
      t.integer :school_id
    end
  end

  def down
    drop_table :auto_line_items
  end
end
