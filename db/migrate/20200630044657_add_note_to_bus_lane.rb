class AddNoteToBusLane < ActiveRecord::Migration[5.0]
  def up
    add_column :bus_lanes, :note, :string
  end

  def down
    remove_column :bus_lanes, :note
  end
end
