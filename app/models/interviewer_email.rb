class InterviewerEmail < ApplicationRecord
  belongs_to :interview
  after_save :send_email
  def send_email
    InterviewMailer.interview_notification(interview, email).deliver
  end
end