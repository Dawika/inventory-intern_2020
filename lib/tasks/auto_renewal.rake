desc 'license renewal reminder'
namespace :auto_renewal do
    task :license_renewal_reminder => :environment do |task, args|

      today = DateTime.now.utc.to_date
      renewal_schools = 0
      School.where(plan: [Plan.monthly,Plan.yearly], auto_subscribe: true).each do |school|
        active_license = school.active_license
        if active_license.present?
          next if active_license.renewal_reminder_sent
          next unless (active_license.expired_date - 2.day).to_date <= today
          ap "Sending license renewal reminder to : #{school.email}..."
          renewal_schools += 1
          active_license.renewal_reminder_sent = true
          active_license.save
        end
      end
      puts "Renewal reminder email sent to #{renewal_schools} schools."
    end
end