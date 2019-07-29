class CreatePlan < ActiveRecord::Migration[5.0]
  def change
    create_table :plans do |t|
      t.string :package_name
      t.string :description
      t.decimal :price
    end
  end
end
