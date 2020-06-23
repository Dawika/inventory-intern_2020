class BusLane < ApplicationRecord
    belongs_to :bus
    has_many :students_bus_lanes
    has_many :employees_bus_lanes
    has_and_belongs_to_many :employees, join_table: "employees_bus_lanes"
    has_and_belongs_to_many :students, join_table: "students_bus_lanes"
end