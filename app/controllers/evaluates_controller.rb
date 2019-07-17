require 'securerandom'

class EvaluatesController < ApplicationController
  # GET /evaluate/1/update
  def show

<<<<<<< HEAD
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

  
=======
    @evaluate = Evaluate.find(params[:id])
    @interview = @evaluate.interviewer_email.interview
    @listnum = (0..20).map
  end

  def update
    @evaluate = Evaluate.find_by(id: params[:id])
    @evaluate.is_submit = true
    @evaluate.update(evaluate_params)
    @interview = @evaluate.interviewer_email.interview
    redirect_to "/somsri#/candidate/detail/#{@interview.candidate_id}"  

  end

  def evaluate_params
    params.require(:evaluate).permit(:frontend, :dot_net, :dot_net_core,
     :ruby_on_rails, :kotlin, :swift, :other_ability, :problem_solving,
     :indepentdent, :comunication, :attention, :on_time, :teamwork,
     :compatibility, :note, :glad, :is_submit)
  end
>>>>>>> evaluate can update and cannot edit after submit (complete)
end