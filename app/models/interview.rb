class Interview < ApplicationRecord
  belongs_to :candidate
  has_many :interviewer_emails
  accepts_nested_attributes_for :interviewer_emails, reject_if: :all_blank, allow_destroy: true
end