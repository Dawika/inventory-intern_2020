class ExpenseItem < ApplicationRecord
  belongs_to :expense
  belongs_to :expense_tag
end
