require 'securerandom'

class EvaluatesController < ApplicationController
  # GET /evaluates/c164db95-5808-4d3c-8290-c6d86af9bc1a
  def show
    @evaluate = Evaluate.find_by(link: params[:id])
    if (@evaluate.blank?)
      redirect_to '/404.html' and return 
    end
    @interview = @evaluate.interviewer_email.interview
    @listnum = (0..20).map
  end

  def update
    @evaluate = Evaluate.find_by(id: params[:id])
    @evaluate.is_submit = true
    @evaluate.update(evaluate_params)
    redirect_to "/evaluates/#{@evaluate.link}"  

  end

  def evaluate_params
    params.require(:evaluate).permit(:frontend, :dot_net, :dot_net_core,
     :ruby_on_rails, :kotlin, :swift, :other_ability, :problem_solving,
     :indepentdent, :comunication, :attention, :on_time, :teamwork,
     :compatibility, :note, :glad, :is_submit)
  end

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
      url = evaluate_url(interviewer_email.evaluate.link)
      InterviewMailer.evaluate_notification(@interview, url, interviewer_email.email).deliver
    end
  end

  private

  def interviewer_email_params
    params.require(:interview).permit(
      interviewer_emails_attributes: [:id, :email, :skip_send_email, :_destroy]
    )
  end
end