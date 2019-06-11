class SchoolMailer < ApplicationMailer
  default from: 'somsri.io'
  def school_notification(school)
    @school = school
    @email = "#{@school.users.first.email}"
    mail(to: @email, subject: 'sign up')
  end
end
