class InterviewMailer < ApplicationMailer
  default from: 'hr@bananacoding.com'

  def interview_notification(interview, email)
    @interview = interview
    mail(to: email, subject: "นัดสัมภาษณ์ #{@interview.candidate.full_name}")
  end

  def edit_interview_notification(interview, email)
    @interview = interview
    mail(to: email, subject: "ขอแก้ไขนัดสัมภาษณ์  #{@interview.candidate.full_name}")
  end

  def evaluate_notification(interview, evaluate, email)
    @interview = interview
    @evaluate = evaluate
    @url = evaluate_url(@evaluate.link)
    mail(to: email, subject: "แบบฟอร์มสัมภาษณ์ #{@interview.candidate.full_name}")
  end
end