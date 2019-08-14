class AddCustomerIdToSchool < ActiveRecord::Migration[5.0]
  def change
    add_column :schools, :customer_id, :string
  end
end
