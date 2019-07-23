require 'securerandom'

class EvaluatesController < ApplicationController

  def show_conclusion
    candidate = Candidate.find(params[:id]).as_json('evaluates')

    render json: {result: candidate}, status: :ok
  end

  def save_invite
    @interview = Interview.find(params[:id])
    ap params[:interview]
    # interview.attributes = interviewer_email_params
    # interview.save
    send_email
    id_candidate = @interview.candidate_id
    render json: {result: Candidate.find(id_candidate).as_json('evaluates')}, status: :ok
  
  end

  def send_email
    evaluates = @interview.interviewer_emails
    evaluates.each do |x|
      link_random = SecureRandom.uuid
      # x.evaluate.create(link: link_random, interview_id: @interview.id)
      # InterviewMailer.evaluate_notification(@interview, x.evaluate, x.email).deliver
      ap link_random 
      ap x.email
    end
  end

  

  private

  def interviewer_email_params
    params.require(:interview).permit(
      interviewer_emails_attributes: [:id, :email, :skip_send_email, :_destroy]
    )
  end

  
end