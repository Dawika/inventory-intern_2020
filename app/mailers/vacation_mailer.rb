class VacationMailer < ApplicationMailer
  def self.notify(user, vacation)
    recipients = User.with_any_role(:approver, :admin, :human_resource)
    recipients.each do |recipient|
      send_notification(recipient, user, vacation).deliver
    end
  end

  def send_notification(recipient, user, vacation)
    @user = user
    @vacation = vacation
    mail(to: recipient.email, subject: "#{@user.full_name} #{@vacation.vacation_type.name}")
  end

  def self.sick_leave_request(user, vacation)
    recipients = User.with_role(:approver)
    recipients.each do |recipient|
      send_sick_leave_request(recipient, user, vacation).deliver
    end
  end

  def send_sick_leave_request(recipient, user, vacation)
    @user = user
    @vacation = vacation
    setup_link(vacation)
    mail(to: recipient.email, subject: "#{@user.full_name} ยื่นคำขอลาป่วย")
  end

  def self.vacation_leave_request(user, vacation)
    recipients = User.with_any_role(:approver, :admin, :human_resource)
    recipients.each do |recipient|
      send_vacation_leave_request(recipient, user, vacation).deliver
    end
  end

  def send_vacation_leave_request(recipient, user, vacation)
    @user = user
    @vacation = vacation
    setup_link(vacation)
    mail(to: recipient.email, subject: "#{@user.full_name} ยื่นคำขอลากิจ")
  end

  def self.switch_date_request(user, vacation)
    recipients = User.with_role(:approver)
    recipients.each do |recipient|
      send_switch_date_request(recipient, user, vacation).deliver
    end
  end

  def send_switch_date_request(recipient, user, vacation)
    @user = user
    @vacation = vacation
    setup_link(vacation)
    mail(to: recipient.email, subject: "#{@user.full_name} ยื่นคำขอสลับวันทำงาน")
  end

  def self.work_at_home_request(user, vacation)
    recipients = User.with_role(:approver)
    recipients.each do |recipient|
      send_work_at_home_request(recipient, user, vacation).deliver
    end
  end

  def send_work_at_home_request(recipient, user, vacation)
    @user = user
    @vacation = vacation
    setup_link(vacation)
    mail(to: recipient.email, subject: "#{@user.full_name} ยื่นคำขอทำงานที่บ้าน")
  end

  def self.response_mail(vacation)
    send_response_mail(vacation.requester, vacation)
    recipients = User.with_any_role(:approver, :admin, :human_resource)
    is_requester = false
    recipients.each do |recipient|
      send_response_mail(recipient, vacation).deliver
      is_requester = true if recipient.id == vacation.requester.id
    end
    send_mail_to_requester(vacation.requester, vacation).deliver if !is_requester
  end

  def send_response_mail(recipient, vacation)
    @vacation = vacation
    setup_link(vacation)
    mail(to: recipient.email, subject: "ผลการยื่นคำขอ #{vacation.vacation_type.name}")
  end

  def setup_link(vacation)
    @approve_url = "#{ENV['DEFAULT_SITE_URL'] || Figaro.env.ENDPOINT}/vacations/#{vacation.id}/approve"
    @reject_url = "#{ENV['DEFAULT_SITE_URL'] || Figaro.env.ENDPOINT}/vacations/#{vacation.id}/reject"
    @dashboard_url = "#{ENV['DEFAULT_SITE_URL'] || Figaro.env.ENDPOINT}/somsri#/vacation/dashboard/"
  end

  def send_mail_to_requester(recipient, vacation)
    @vacation = vacation
    mail(to: recipient.email, subject: "#{vacation.approver.first_name} ได้ #{I18n.t(@vacation.status)} คำขอของ #{vacation.requester.first_name}")
  end

end
