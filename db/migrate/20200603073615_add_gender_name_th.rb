class AddGenderNameTh < ActiveRecord::Migration[5.0]
  def change
    add_column :genders, :name_th, :string

    add_column :students, :blood_type, :string
    add_column :students, :race, :string, default: "THA"
    add_column :students, :religion, :string, default: "Buddhism"
    add_column :students, :Number_of_Relatives, :integer, default: 1
    add_column :students, :Being_the_Number_of, :integer, default: 1

    create_table :addresses do |t|
      t.string :type
      t.string :address_text
      t.string :sub_district
      t.string :district
      t.string :province
      t.string :country
      t.string :postcode
      t.string :reference
      t.string :reference_id
      t.timestamps
    end

    create_table :student_illnesses do |t|
      t.string :type
      t.string :name
      t.string :symptoms
      t.string :medicine
      t.string :medicine_allergy
      t.string :remark
      t.timestamps
    end

    add_column :parents, :birthdate, :date
    add_column :parents, :gender_id, :integer
    add_column :parents, :blood_type, :string
    add_column :parents, :nationality, :string, default: "THA"
    add_column :parents, :race, :string
    add_column :parents, :religion, :string, default: "Buddhism"
    add_column :parents, :marital_status, :string
    add_column :parents, :is_living, :boolean, default: true 
    add_column :parents, :relation, :string
    add_column :parents, :education, :string
    add_column :parents, :education_title, :string
    add_column :parents, :occupation, :string
    add_column :parents, :occupation_title, :string
    add_column :parents, :work_place, :string
    add_column :parents, :average_salary, :integer

  end
end
