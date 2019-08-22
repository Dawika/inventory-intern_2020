class ChangeTypeCategoryInterview < ActiveRecord::Migration[5.0]
  def up
    change_column :interviews, :category, 'integer USING CAST(category AS integer)', default: 1
  end

  def down
    change_column :interviews, :category, :string
  end
end
