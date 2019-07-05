class InterviewsController < ApplicationController

  def create
    if interview_params[:id].present?
      interview = Interview.find(interview_params[:id])
      interview.update(interview_params)
      interview.interviewer_emails.each do |interviewer|
        InterviewMailer.edit_interview_notification(interview, interviewer.email).deliver
      end
    else
      interview = Interview.create(interview_params)
    end
    render json: { candidate: interview.candidate.as_json('show_or_edit') }, status: :ok
  end

  private

  def interview_params
    params.require(:interview).permit(
      :id, 
      :date, 
      :location, 
      :candidate_id, 
      :category,
      interviewer_emails_attributes: [:id, :email, :_destroy])
  end
end