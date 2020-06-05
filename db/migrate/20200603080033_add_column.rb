class AddColumn < ActiveRecord::Migration[5.0]
  def change
    add_column :student_illnesses, :illness_type, :string  
    add_column :addresses, :address_type, :string
  end
end
