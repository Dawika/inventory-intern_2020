class GradesController < ApplicationController
  load_and_authorize_resource

  # GET /grades
  def index
    @grades = Grade.order(index_sorting: 'desc', created_at: 'desc').where(school_id: current_user.school.id).to_a
    @grades << Grade.new(name: 'All', id: -1)
    render json: @grades, status: :ok
  end

  def create
    grade = Grade.new(name: params[:grade], school_id: current_user.school_id)
    if grade.save
      list_grade
    else
      render json: {error: true}
    end
  end

  def destroy
    grade = Grade.find(params[:id])
    if grade.delete
      list_grade
    else 
      render json: {error: true}
    end
  end

  def update
    grade = Grade.find(params[:id])
    if grade.name != params[:grade]
      grade.name = params[:grade]
      grade.save
      render json: {error: false}
    else
      render json: {error: true}
    end
  end
  
  # POST /grades/grade_sorting
  def grade_sorting
    number_sorting = params[:params].count + 1
    params[:params].each_with_index do |info, index|
      grade_sorting = Grade.find_by(id: params[:params][index][:id])
      grade_sorting.index_sorting = number_sorting -= 1
      grade_sorting.save
      if info == params[:params].last
        number_sorting = params[:params].count + 1
      end
    end
  end

  def list_grade
    grades = Grade.order(index_sorting: 'desc', created_at: 'desc').where(school_id: current_user.school.id).to_a
    render json: grades, status: :ok
  end

end
