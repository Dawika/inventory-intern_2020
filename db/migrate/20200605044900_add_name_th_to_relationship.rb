class AddNameThToRelationship < ActiveRecord::Migration[5.0]
  def change
  	add_column :relationships, :name_th, :string
  end
end
