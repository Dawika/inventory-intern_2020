class AddSchoolIdToParent < ActiveRecord::Migration[5.0]
  def change
    add_reference :parents, :school, foreign_key: { to_table: :schools }
  end
end
