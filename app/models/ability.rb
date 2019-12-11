class Ability
  include CanCan::Ability

  def initialize(user)
    case user

    when User
      if user.admin?
        can :manage, [:menu, :setting]
        can :manage, AccountType
        can :manage, Account
        can :manage, Alumni
        can :manage, Bank
        can :manage, BilInfo
        can :manage, CandidateFile
        can :manage, Candidate
        can :manage, Category
        can :manage, ChargeInfo
        can :manage, Classroom
        can :manage, DailyReport
        can :manage, DesignSkill
        can :manage, EmployeeSkill
        if SiteConfig.get_cache.web_cms
          can :manage, Employee, school_id: user.school_id
        else
          can :manage, Employee
        end
        can :manage, Evaluate
        can :manage, ExpenseItem
        can :manage, ExpenseTag
        can :manage, Expense
        can :manage, Gender
        can :manage, Grade
        can :manage, GroupingReportOption
        can :manage, Holiday
        can :manage, Individual
        can :manage, Interview
        can :manage, InterviewerEmail
        can :manage, InventoryRepair
        can :manage, InventoryRequest
        can :manage, Inventory
        can :manage, InvoiceStatus
        can :manage, Invoice
        can :manage, License
        can :manage, LineItemQuotation
        can :manage, LineItem
        can :manage, List
        can :manage, LtBank
        can :manage, ManageInventoryRepair
        can :manage, ManageInventoryRequest
        can :manage, Parent
        can :manage, PaymentMethod
        can :manage, Payroll
        can :manage, Plan
        can :manage, ProgrammingSkill
        can :manage, QuotationInvoice
        can :manage, Quotation
        can :manage, Relationship
        can :manage, Role
        can :manage, RollCall
        can :manage, SchoolSetting
        can :manage, School
        can :manage, SiteConfig
        can :manage, Skill
        can :manage, SoftSkill
        can :manage, StudentList
        can :manage, Student
        can :manage, StudentsParent
        can :manage, Supplier
        can :manage, TaxReduction
        can :manage, Taxrate
        can :manage, TeacherAttendanceList
        can :manage, User
        can :manage, VacationConfig
        can :manage, VacationLeaveRule
        can :manage, VacationSetting
        can :manage, VacationType
        can :manage, Vacation
        can :manage, :cannot_leave
        cannot :access, :rails_admin
        cannot :dashboard
      end
      if  user.finance_officer?
        can :manage, [:menu, :setting]
        can :manage, Invoice
        can :manage, InvoiceStatus
        can :manage, DailyReport
        can :manage, Grade #read
        can :manage, Student
        can :manage, Parent
        can :manage, School #read
        can :manage, Classroom
        can :manage, Alumni
        can :manage, SiteConfig #read
        can :manage, Expense
        can :manage, ExpenseTag
        can :manage, ExpenseItem
        can :manage, Bank
        can :manage, Quotation
        can :manage, QuotationInvoice
        can :manage, LineItemQuotation
        can :read, School
      end
      if user.human_resource?
        can :manage, [:menu, :setting]
        can :manage, Invoice
        can :manage, Payroll
        can :manage, Employee
        can :manage, Vacation
        can :manage, VacationConfig
        can :manage, Individual
        can :manage, EmployeeSkill
        can :manage, Skill
        can :manage, RollCall
        can :read, Inventory
        can :manage, InventoryRequest
      end
      if user.procurement_officer?
        can :manage, [:menu, :setting]
        can :manage, Inventory
        can :manage, InventoryRequest
        can :manage, InventoryRepair
        can :manage, Employee
        can :manage, Supplier
      end
      if user.teacher?
        can :manage, [:menu, :setting]
        can :manage, Invoice
        can :manage, Alumni
        can :manage, Student
        can :manage, Parent
        can :read, Individual
      end
      if user.employee?
        can :manage, [:menu, :setting]
        can :read, Invoice
        can :manage, DailyReport
        can :read, Grade
        can :manage, Student
        can :manage, Parent
        can :read, School
        can :manage, :setting
        can :manage, Classroom
        can :manage, Alumni
        can :read, SiteConfig
        can :manage, Expense
        can :manage, ExpenseTag
        can :manage, ExpenseItem
        can :manage, Vacation, :requester_id => user.id
        can :read, Inventory
        can :read, EmployeeSkill
        can :read, Skill
        can :read, RollCall
        can :manage, Payroll, employee_id: user.id
        can :read, Individual
        can :manage, Employee, id: user.id
        can :manage, InventoryRequest, employee_id: user.id

        if user.approver?
          can :manage, VacationConfig
          can [:approve, :reject], Vacation
        else
          can :read, VacationConfig
        end
      end

      if user.super_admin?
        can :access, :rails_admin
        can :dashboard
        can :manage, :all
        can :manage, :cannot_leave
        can :manage, SiteConfig
        can :update, VacationLeaveRule
      end
    end
  end

  def as_json(options={})
    update = {}
    manage = {}
    manage[:all] = true if self.can? :manage, :all
    manage[:menu] = true if self.can? :manage, :menu
    manage[:invoice] = true if self.can? :manage, Invoice
    manage[:daily_report] = true if self.can? :manage, DailyReport
    manage[:roll_call] = true if self.can? :manage, RollCall
    manage[:expense] = true if self.can? :manage, Expense
    manage[:report_roll_call] = true if self.can? :manage, :report_roll_call
    manage[:student] = true if self.can? :manage, Student
    manage[:parent] = true if self.can? :manage, Parent
    manage[:setting] = true if self.can? :manage, :setting
    manage[:school] = true if self.can? :manage, School
    manage[:vacation] = true if self.can? :manage, Vacation
    manage[:vacation_config] = true if self.can? :manage, VacationConfig
    manage[:inventory] = true if self.can? :manage, Inventory
    manage[:employee] = true if self.can? :manage, Employee
    manage[:employee_me] = true
    update[:vacation_leave_rules] = true if self.can? :update, VacationLeaveRule
    manage[:supplier_details] = true if self.can :manage, Supplier
    manage[:cannot_leave] = true if self.can? :manage, :cannot_leave
    result = {
      update: update,
      manage: manage
    }
    return result
  end
end
