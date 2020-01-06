class AddSchoolIdToExpensesTables < ActiveRecord::Migration[5.0]
  def change
    add_reference :banks, :school, foreign_key: true
    add_reference :grades, :school, foreign_key: true
    add_reference :expenses, :school, foreign_key: true
    add_reference :expense_tags, :school, foreign_key: true
  end
end
