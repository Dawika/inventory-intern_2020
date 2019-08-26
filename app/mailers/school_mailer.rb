class SchoolMailer < ApplicationMailer
  default from: 'somsri.io'
  
  def school_notification(school)
    @school = school
    @start_date = @school.licenses.first.created_at
    @expired_date = @school.licenses.first.expired_date
    mail(to: @school.email, subject: 'sign up')
  end

  def license_renewal_reminder(schools)
      @school = schools
      mail(to: @school.email, subject: 'license renewal reminder')
  end

  def renew_license_success_and_error(schools)
    @school = schools
    mail(to: @school.email, subject: 'license renewal ')
  end

end
