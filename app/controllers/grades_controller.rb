class GradesController < ApplicationController
  load_and_authorize_resource

  # GET /grades
  def index
    @grades = Grade.order(index_sorting: 'asc').where(school_id: current_user.school.id).to_a
    @grades << Grade.new(name: 'All', id: -1)
    render json: @grades, status: :ok
  end

  def destroy
    # grade = Grade.find(params[:id])
    # grade.delete
    ap 'sss'
  end

  def update_grade
    params[:grades].each_with_index do |info, index|
      grade_sorting = Grade.find_by(id: params[:grades][index][:id])
      grade_sorting.name = params[:grades][index][:name]
      grade_sorting.save
    end
  end
  
  # POST /grades/grade_sorting
  def grade_sorting
    number_sorting = 0
    params[:params].each_with_index do |info, index|
      grade_sorting = Grade.find_by(id: params[:params][index][:id])
      grade_sorting.index_sorting = number_sorting+= 1
      grade_sorting.save
      if info == params[:params].last
        number_sorting = 0
      end
    end
  end

end
