class Invoice < ApplicationRecord
  belongs_to :user
  belongs_to :student, -> { with_deleted }
  belongs_to :parent, -> { with_deleted }
  belongs_to :invoice_status
  has_many :line_items
  has_many :payment_methods
  has_many :quotation_invoices

  self.per_page = 10

  scope :in_school, -> (school_id) { where(school_id: school_id)
                                     .where("date_part('year', created_at) = ?", Date.today.year)
                                   }
  scope :latest, -> { order("created_at DESC").first }

  def helper
    @helper ||= Class.new do
      include ActionView::Helpers::NumberHelper
    end.new
  end

  def parent
    Parent.with_deleted.where(id: self.parent_id).first
  end

  def student
    Student.with_deleted.where(id: self.student_id).first
  end

  def total_amount
    self.line_items.collect(&:total_price).inject(:+)
  end

  def entrance_fee
    entrance_fee = self.line_items.select{|l| (l.detail && l.detail.include?('entrance'))}.first
    entrance_fee.nil? ? 0 : entrance_fee.amount
  end

  def other_fee
    self.line_items.collect{|item| item.amount unless item.detail =~ /Tuition Fee/ }.compact.inject(:+)
  end

  def tuition_fee
    self.line_items.collect{|item| item.amount if item.detail =~ /Tuition Fee/ }.compact.inject(:+)
  end

  def student_full_name_with_nickname
    self.student.invoice_screen_full_name_display if self.student
  end

  def student_classroom
    self.student.classroom_number
  end

  def parent_name
    self.parent.full_name if self.parent
  end

  def payee_name
    self.user.employee.full_name if self.user
  end

  def payment_method_names
    self.payment_methods.collect(&:payment_method).join(', ')
  end

  def payment_note
    result = ""
    self.payment_methods.each do |pay|
      case pay.payment_method # a_variable is the variable we want to compare
      when "เช็คธนาคาร"    #compare to 1
        result += pay.cheque_number
      when "เงินโอน"
        result += pay.transfer_bank_name || "-"
      else
        result += "-"
      end
      result += ", " if pay != self.payment_methods.last
    end
    result
  end

  def status_name
    self.invoice_status.name == 'Active' ? I18n.t('paid') : I18n.t('cancel')
  end

  def is_cancel
    self.invoice_status.name == 'Canceled'
  end

  def grade_classroom
    if self.grade_name.blank?
      if self.classroom.blank?
        return nil
      else
        return "#{self.classroom}"
      end
    else
      if self.classroom.blank?
        return "#{self.grade_name}"
      else
        return "#{self.grade_name} (#{self.classroom})"
      end
    end
  end

  def self.search(keyword)
    if keyword.to_s != ''
      joins(:parent, :student).where(
        "CAST(invoices.id AS TEXT) LIKE :search OR
        students.full_name LIKE :search OR
        students.full_name_english LIKE :search OR
        students.nickname LIKE :search OR
        parents.full_name LIKE :search", search: "%#{keyword}%"
      )
    else
      self.all
    end
  end

  def as_json(options={})
    if options[:index]
      return {
        id: self.id,
        student_id: self.student_id,
        parent_id: self.parent_id,
        user_id: self.user_id,
        remark: self.remark,
        payment_method_id: self.payment_method_id,
        cheque_bank_name: self.cheque_bank_name,
        cheque_number: self.cheque_number,
        cheque_date: self.cheque_date,
        transfer_bank_name: self.transfer_bank_name,
        transfer_date: self.transfer_date,
        invoice_status_id: self.invoice_status_id,
        school_year: self.school_year,
        semester: self.semester,
        created_at: self.created_at,
        updated_at: self.updated_at,
        status_daily_report: self.status_daily_report,
        students: {
          full_name: self.student_full_name_with_nickname,
        },
        grade_name: self.grade_name,
        parents: {
          full_name: self.parent_name,
        },
        users: {
          full_name: self.payee_name,
        },
        payment_methods: {
          payment_method: self.payment_method_names,
          payment_note: self.payment_note
        },
        line_items: {
          amount:self.total_amount,
        },
        invoice_statuses: {
          name: self.status_name,
        },
        is_cancel: self.is_cancel
      }
    elsif options[:bootstrap_table]
      return {
        id: self.id,
        payment_method_id: self.payment_method_id,
        invoice_status_id: self.invoice_status_id,
        school_year: self.school_year,
        semester: self.semester,
        amount: helper.number_with_delimiter('%.2f' % self.total_amount, :delimiter => ','),
        created_at: self.created_at,
        grade_classroom: self.grade_classroom,
        payment_methods: self.payment_method_names,
        invoice_status: self.invoice_status.name
      }
    else
      super()
    end
  end
end
