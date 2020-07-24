class BusLane < ApplicationRecord
  belongs_to :bus
  has_many :students_bus_lanes, dependent: :destroy
  has_many :employees_bus_lanes, dependent: :destroy
  has_and_belongs_to_many :employees, join_table: "employees_bus_lanes"
  has_and_belongs_to_many :students, join_table: "students_bus_lanes"

  def as_json(options = {})
    if options['index']
      {
        id: self.id,
        name: self.name,
        bus: self.bus.license_plate,
        employee: self.employees.first&.full_name,
        students: self.students.count
      }
    else
      super()
    end
  end
end