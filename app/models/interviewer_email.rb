class InterviewerEmail < ApplicationRecord
  attr_accessor :skip_send_email
  
  belongs_to :interview
  has_one :evaluate
<<<<<<< HEAD
  after_save :send_email, unless: :skip_send_email
  scope :is_submited, -> { joins(:evaluate).where('evaluates.is_submit = true') }
  scope :is_not_submited, -> { joins(:evaluate).where('evaluates.is_submit = false') }

=======
  after_save :send_email
>>>>>>> evaluate frontend
  def send_email
    InterviewMailer.interview_notification(interview, email).deliver
  end
end