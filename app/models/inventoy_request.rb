class InventoyRequest < ApplicationRecord
	belongs_to :user
	belongs_to :inventory
	enum inventory_status: [:pending, :approved, :rejected , :done]

	def inventory_name
		self.inventory.item_name
	end
end
