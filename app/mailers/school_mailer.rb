class SchoolMailer < ApplicationMailer
  default from: 'somsri.io'
  
  def school_notification(school)
    @school = school
    @email = "#{@school.users.first.email}"
    created_at = @school.user.created_at
    @date = {
      start_date: created_at,
      end_date: created_at + 3.month
    }
    mail(to: @email, subject: 'sign up')
  end
end
