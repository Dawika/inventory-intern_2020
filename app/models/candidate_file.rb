class CandidateFile < ApplicationRecord
    belongs_to :candidate
    has_attached_file :files
    validates_attachment_content_type :files, content_type: ["application/pdf", "image/jpeg", "image/png", "image/jpg"]
  end