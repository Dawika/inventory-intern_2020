class SchoolMailer < ApplicationMailer
  default from: 'info@somsri.io'
  
  def school_notification(school)
    @school = school
    @start_date = @school.licenses.first.created_at
    @expired_date = @school.licenses.first.expired_date
    mail(to: @school.email, subject: 'sign up')
  end

  def notify_admin(school, domain)
    @school = school
    @domain_name = domain
    mail(to: 'accounting@bananacoding.com', subject: 'แจ้งผลการสมัครสมาชิคของ somsri.io')
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
