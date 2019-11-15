class UpdateDataExpenseItem < ActiveRecord::Migration[5.0]
  def change
    tag_tree = SiteConfig.get_cache.expense_tag_tree_hash
    min_lv = nil
    tag_tree.each do |t|
      min_lv = t and next if min_lv.blank?
      if t[:lv] < min_lv[:lv]
        min_lv = t
      else
        expense_item_ids = ActiveRecord::Base.connection.exec_query('select id from expense_tag_items;').rows.flatten.uniq
        ExpenseItem.where(id: expense_item_ids).update(expense_tag_id: min_lv[:id])
        min_lv = t
      end
    end

    if min_lv.present?
      expense_item_ids = ActiveRecord::Base.connection.exec_query('select id from expense_tag_items;').rows.flatten.uniq
      ExpenseItem.where(id: expense_item_ids).update(expense_tag_id: min_lv[:id])
    end
  end
end
