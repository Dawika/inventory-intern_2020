require 'securerandom'

class EvaluatesController < ApplicationController

  def show_conclusion
    candidate = Candidate.find(params[:id]).as_json('evaluates')

    render json: {result: candidate}, status: :ok
  end

  def save_invite
    @interview = Interview.find(params[:id])
    #เป็น temp code ที่ต้องใช้
    @interview.attributes = interviewer_email_params
    @interview.save
    send_email
    id_candidate = @interview.candidate_id
    render json: {result: Candidate.find(id_candidate).as_json('evaluates')}, status: :ok
  
  end

  def send_email
    @interview.interviewer_emails.each do |interviewer_email|
      link_random = SecureRandom.uuid
      #เป็น temp code ที่ต้องใช้
      Evaluate.create(link: link_random, interviewer_email_id: interviewer_email.id, interview_id: @interview.id)
      InterviewMailer.evaluate_notification(@interview, interviewer_email.evaluate, interviewer_email.email).deliver
    end
  end

  

  private

  def interviewer_email_params
    params.require(:interview).permit(
      interviewer_emails_attributes: [:id, :email, :skip_send_email, :_destroy]
    )
  end

  
end