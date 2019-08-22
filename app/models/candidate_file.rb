class CandidateFile < ApplicationRecord
  belongs_to :candidate
  has_attached_file :files, styles: lambda { |a| a.instance.check_file_type }
  validates_attachment_content_type :files, content_type: ["application/pdf", "image/jpeg", "image/png", "image/jpg"]

  def is_image?
    self.files.content_type =~ %r(image)
  end

  def check_file_type
    if self.is_image?
      {
        :thumb => "100x100>", 
        :medium => "300x300>"
      }
    else
      {
        
      }
    end
  end
end
