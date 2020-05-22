class EmployeeMailer < ApplicationMailer
	def send_employee_invite(employee, token, subdomain, domain_name)
		@employee = employee
		@token = token
		@subdomain = subdomain
		@domain_name = domain_name
		mail(to: employee.email, subject: "ยินดีต้อนรับเข้าสู่ Somsri.io")
	end	

end
