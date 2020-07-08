class BusLanesController < ApplicationController

  def index
    bus = BusLane.where(school_id: current_user.school_id).order(id: 'desc')
    total = bus.size
    bus = bus.offset(params[:offset]).limit(params[:limit])
    render json: {
      rows: bus.as_json('index'),
      total: total
    }, status: :ok
  end

  def get_info
    bus = Bus.where(school_id: current_user.school_id)
    employees = Employee.where(school_id: current_user.school_id)
    students = []
    Student.includes(:grade, :classroom, school: [:school_settings]).where(school_id: current_user.school_id).each do |student|
      classroom = student.classroom&.name.present? ? "#{student.grade&.name}/#{student.classroom&.name}" : "#{student.grade&.name}"
      students << {
          id: student.id,
          full_name: student.full_name,
          classroom: classroom
      }
    end
    render json: {
        bus: bus,
        employees: employees,
        students: students
    }
  end

  def get_buslane
    bus_lane = BusLane.find(params[:bus_lane])
    students = []
    bus_lane.students.includes(:grade, :classroom, school: [:school_settings]).each do |student| 
      classroom = student.classroom&.name.present? ? "#{student.grade&.name}/#{student.classroom&.name}" : "#{student.grade&.name}"
      students << {
        id: student.id,
        full_name: student.full_name,
        classroom: classroom
    }
    end
    render json: {
      name: bus_lane.name,
      bus_lane: bus_lane.bus,
      employee: bus_lane.employees.first,
      note: bus_lane.note,
      students: students
    }
  end

  def create
    BusLane.transaction do
      @buslane = BusLane.create(params_buslane)
      create_student
      @buslane.employees_bus_lanes.create(employee_id: params[:bus_lane][:employee_id])
    end
    render json: {success: true}, status: :ok
  end

  def update
    ActiveRecord::Base.transaction do
      @buslane = BusLane.find(params[:id])
      @buslane.update(params_buslane)
      @buslane.students_bus_lanes.delete_all
      create_student
      @buslane.employees_bus_lanes.first.update(employee_id: params[:bus_lane][:employee_id])
    end
    render json: {success: true}, status: :ok
  end

  def destroy
    buslane = BusLane.find(params[:id])
    buslane.destroy
    render json: {success: true}, status: :ok
  end

  def params_buslane
    params.require(:bus_lane).permit(:name, :bus_id, :note).merge(school_id: current_user.school_id)
  end

  def create_student
    params[:bus_lane][:student_id].each_with_index do |id, index|
      @buslane.students_bus_lanes.create(student_id:  params[:bus_lane][:student_id][index][:id])
    end
  end

end
  