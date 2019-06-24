class EmployeeMailer < ApplicationMailer
	def send_employee_invite(employee, token)
		@employee = employee
		@token = token
		mail(to: employee.email, subject: "ยินดีต้อนรับเข้าสู่ Somsri.io")
	end	

end
