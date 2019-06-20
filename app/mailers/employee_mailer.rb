class EmployeeMailer < ApplicationMailer
	def send_employee_invite(employee)
		@employee = employee
		mail(to: employee.email, subject: "ยินดีต้อนรับสู่ Bananacoding")
	end	

end
