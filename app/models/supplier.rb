class Supplier < ApplicationRecord
	has_many :inventories

	def self.search(keyword)
		if keyword.present?
			where("name ILIKE ? OR phone_number ILIKE ? ", "%#{keyword}%", "%#{keyword}%")
    else 
			self.all
		end
	end
end
