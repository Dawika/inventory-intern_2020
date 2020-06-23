class Bus < ApplicationRecord
    has_many :bus_lanes
    belongs_to :employee
end