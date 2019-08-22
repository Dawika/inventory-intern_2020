class ChangeIsSubmitEvaluates < ActiveRecord::Migration[5.0]
  def change
    change_column :evaluates, :is_submit, :boolean, default: false
  end
end
