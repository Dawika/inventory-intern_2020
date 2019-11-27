class EmployeeMailer < ApplicationMailer
	def send_employee_invite(employee, token, subdomain)
		@employee = employee
		@token = token
		@subdomain = subdomain
		mail(to: employee.email, subject: "ยินดีต้อนรับเข้าสู่ Somsri.io")
	end	

end
