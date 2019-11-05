class AddAutoSubscribeToSchool < ActiveRecord::Migration[5.0]
  def change
    add_column :schools, :auto_subscribe, :bool, default: true
  end
end
