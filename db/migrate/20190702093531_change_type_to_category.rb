class ChangeTypeToCategory < ActiveRecord::Migration[5.0]
  def change
    remove_column :interviews, :type
    add_column :interviews, :category, :string
  end
end
