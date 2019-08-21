 every 1.minute do
    rake "auto_renewal:license_renewal_reminder"
 end

 every 1.minute do
   rake "auto_renewal:renew_license"
end