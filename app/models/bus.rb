class Bus < ApplicationRecord
  has_many :bus_lanes, dependent: :destroy
  belongs_to :employee

  def as_json(options = {})
    if options['index']
      {
        id: self.id,
        license_plate: self.license_plate,
        province: self.province,
        car_brand: self.car_brand,
        employee: self.employee.full_name,
        created_at: self.created_at.strftime('%d/%m/%y')
      }
    else
      super()
    end
  end
end