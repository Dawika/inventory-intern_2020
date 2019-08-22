class AddColumnLinkToEvaluates < ActiveRecord::Migration[5.0]
  def up
    add_column :evaluates, :link, :string 
    change_column :evaluates, :glad, 'integer USING CAST(glad AS integer)', default: 1
  end

  def down
    remove_column :evaluates, :link
    change_column :evaluates, :glad, :string
  end
end
