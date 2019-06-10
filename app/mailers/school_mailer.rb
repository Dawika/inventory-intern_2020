class SchoolMailer < ApplicationMailer
    default from: 'notifications@example.com'
    
    def school_notification(school)
        @school = school
        # @name = "#{@school.users.email}"
        mail(to: 'asdasd', subject: 'sssss')
    
    end


end
