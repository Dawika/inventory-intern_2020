class DropTableExpenseTagItem < ActiveRecord::Migration[5.0]
  def change
  	drop_table :expense_tag_items
  end
end
