class GradesController < ApplicationController
  load_and_authorize_resource

  # GET /grades
  def index
    @grades = Grade.where(school_id: current_user.school.id).to_a
    @grades << Grade.new(name: 'All', id: -1)
    render json: @grades, status: :ok
  end
end
