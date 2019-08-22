class ChangeOnTimeEvaluate < ActiveRecord::Migration[5.0]
  def change
    change_column :evaluates, :on_time, :boolean, default: false
  end
end
