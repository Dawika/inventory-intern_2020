 every 1.day, at: '0:00 am' do
    rake "auto_renewal:license_renewal_reminder"
 end

 every 1.day, at: '0:00 am' do
   rake "auto_renewal:renew_license"
end