class Evaluate < ApplicationRecord
  belongs_to :interview
  belongs_to :interviewer_email

  enum glad: [:pleased, :so_so, :displeased]
end
