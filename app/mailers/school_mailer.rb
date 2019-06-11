class SchoolMailer < ApplicationMailer
    default from: 'notifications@example.com'
  def school_notification(school)
    @school = school
    @email = "#{@school.users.first.email}"
    mail(to: @email, subject: 'test')
  end
end
