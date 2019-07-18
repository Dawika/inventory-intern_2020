class AddSchoolIdToClassroom < ActiveRecord::Migration[5.0]
  def change
    add_reference :classrooms, :school, foreign_key: { to_table: :schools }
  end
end
