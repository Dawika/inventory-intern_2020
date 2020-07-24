class BusesController < ApplicationController

  def index
    buses = Bus.includes(:employee).where(school_id: current_user.school_id).order(id: 'desc')
    total = buses.size
    buses = buses.offset(params[:offset]).limit(params[:limit])
    render json: {
      rows: buses.as_json('index'),
      total: total
    }, status: :ok
  end

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