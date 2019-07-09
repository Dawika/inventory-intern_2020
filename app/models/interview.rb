class Interview < ApplicationRecord
  belongs_to :candidate
  has_many :interviewer_emails
  has_many :evaluates
  accepts_nested_attributes_for :interviewer_emails, reject_if: :all_blank, allow_destroy: true
  after_update :send_mail_to_interviewers

  def send_mail_to_interviewers
    if self.changed?
      interviewer_emails.each do |interviewer|
        InterviewMailer.edit_interview_notification(self, interviewer.email).deliver
      end
    end
  end
end