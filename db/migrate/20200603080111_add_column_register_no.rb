class AddColumnRegisterNo < ActiveRecord::Migration[5.0]
  def change
    add_column :students, :registration_number, :string
    add_column :parents, :registration_number, :string  
  end
end
