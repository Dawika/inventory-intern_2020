class InterviewerEmail < ApplicationRecord
  belongs_to :interview
  after_save :send_email
  # after_update :send_email_if_email_change

  def send_email
    InterviewMailer.interview_notification(interview, email).deliver
  end

  # def send_email_if_email_change
  #   InterviewMailer.edit_interview_notification(interview, email).deliver
  # end
end