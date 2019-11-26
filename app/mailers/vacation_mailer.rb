class VacationMailer < ApplicationMailer

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

  def self.approved_rejected(vacation)
    send_approved_rejected(vacation.requester, vacation)
    recipients = User.with_role(:approver)
    recipients.each do |recipient|
      send_approved_rejected(recipient, vacation).deliver
    end
  end

  def send_approved_rejected(recipient, vacation)
    @vacation = vacation
    setup_link(vacation)
    mail(to: recipient.email, subject: "ผลการยื่นคำขอ #{vacation.vacation_type.name}")
  end

  def setup_link(vacation)
    @approve_url = "#{ENV['DEFAULT_SITE_URL']}/vacations/#{vacation.id}/approve"
    @reject_url = "#{ENV['DEFAULT_SITE_URL']}/vacations/#{vacation.id}/reject"
    @dashboard_url = "#{ENV['DEFAULT_SITE_URL']}/somsri#/vacation/dashboard/"
  end

  def self.send_mail_to_admin(vacation)
    recipients = User.with_role(:admin)
    recipients.each do |recipient|
      send_mail_response_to_admin(recipient, vacation).deliver
    end
  end

  def send_mail_response_to_admin(recipient, vacation)
    @vacation = vacation
    mail(to: recipient.email, subject: "#{vacation.approver.first_name} ได้ #{I18n.t(@vacation.status)} คำขอของ #{vacation.requester.first_name}")
  end

end
