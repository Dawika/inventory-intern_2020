class AddDateToSaveAndAddSuppilerIdToManageInventoryRequest < ActiveRecord::Migration[5.0]
  def change
  	add_column :manage_inventory_requests, :date_save_step1 , :datetime
  	add_column :manage_inventory_requests, :date_save_step2 , :datetime
  	add_column :manage_inventory_requests, :date_save_step3 , :datetime
  	add_column :manage_inventory_requests, :date_save_step4 , :datetime
  	add_column :manage_inventory_requests, :supplier_id , :integer
  end
end
