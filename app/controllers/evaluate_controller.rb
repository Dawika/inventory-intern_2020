class EvaluateController < HomeController



  # GET /evaluate/56/1/
  def evaluate
    @evaluate = Evaluate.find(params[:id])
    @interview_email = InterviewerEmail.find(@evaluate.interviewer_email_id)
    @interview = Interview.find(@interview_email.interview_id)
    @candidate = Candidate.find(@interview.candidate_id) 
    respond_to do |f|
      f.html { render "evaluate", layout: "application_invoice" }
    end
  end

end