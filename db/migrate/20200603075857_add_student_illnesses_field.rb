class AddStudentIllnessesField < ActiveRecord::Migration[5.0]
  def change
    add_column :student_illnesses, :food_allergy, :string
    add_column :student_illnesses, :operation_history, :string
    add_column :student_illnesses, :student_reference, :string
  end
end
