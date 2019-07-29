class AddForeignKeyToSchool < ActiveRecord::Migration[5.0]
  def change
    add_reference :schools, :plan, foreign_key: {to_table: :plans}
  end
end
