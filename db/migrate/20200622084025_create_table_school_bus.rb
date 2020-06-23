class CreateTableSchoolBus < ActiveRecord::Migration[5.0]
  def up
    create_table :buses do |t|
      t.string :license_plate
      t.string :province
      t.string :car_brand
      t.string :note
      t.references :employee, foreign_key: true
      t.references :school, foreign_key: true
      t.timestamps
    end

    create_table :students_bus_lanes do |t|
      t.belongs_to :student
      t.belongs_to :bus_lane
    end

    create_table :employees_bus_lanes do |t|
      t.belongs_to :employee
      t.belongs_to :bus_lane
    end

    create_table :bus_lanes do |t|
      t.string :name
      t.belongs_to :school
      t.belongs_to :bus
    end

  end

  def down
    drop_table :buses
    drop_table :bus_lanes
    drop_table :students_bus_lanes
    drop_table :employees_bus_lanes
  end
end
