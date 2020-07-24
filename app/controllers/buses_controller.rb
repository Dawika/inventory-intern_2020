class BusesController < ApplicationController

  def create
    Bus.create(bus_params)
    render json: {success: true}
  end

  def get_employee
    employee = Employee.where(school_id: current_user.school_id)
    render json: employee, status: :ok
  end

  def bus_params
    params.required(:bus).permit(:license_plate, :province, :car_brand, :note, :employee_id).merge(school_id: current_user.school_id)
  end

end