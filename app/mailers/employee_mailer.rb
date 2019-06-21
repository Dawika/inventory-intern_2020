class EmployeeMailer < ApplicationMailer
	def send_employee_invite(employee, token)
		@employee = employee
		@token = token
		mail(to: employee.email, subject: "ยินดีต้อนรับสู่ Bananacoding")
	end	

end
