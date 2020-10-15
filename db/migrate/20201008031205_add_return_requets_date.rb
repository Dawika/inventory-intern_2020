class AddReturnRequetsDate < ActiveRecord::Migration[5.0]
  def change
    add_column :inventory_requests, :return_request_date, :datetime
  end
end
