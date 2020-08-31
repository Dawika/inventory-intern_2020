desc 'license renewal reminder'
namespace :auto_renewal do
    task :license_renewal_reminder => :environment do |task, args|

      today = DateTime.now.utc.to_date
      renewal_schools = 0
      School.where.not(plan: nil).each do |school|
        active_license = school.active_license
        if active_license.present?
          next if active_license.renewal_reminder_sent
          next if active_license.expired_date.blank?
          next unless (active_license.expired_date - 2.day).to_date <= today
          ap "Sending license renewal reminder to : #{school.email}..."
          SchoolMailer.license_renewal_reminder(school).deliver
          SchoolMailer.license_renewal_reminder_admin(school).deliver
          renewal_schools += 1
          active_license.renewal_reminder_sent = true
          active_license.save
        end
      end
      ap "Renewal reminder email sent to #{renewal_schools} schools."
    end

    task :renew_licenses => :environment do |task, args|

      now = DateTime.now.utc
      renewal_schools = 0
      error = 0
      School.where(auto_subscribe: true).where.not(plan: nil).each do |school|
        active_license = school.active_license
        if school.present?
          next if active_license.blank?
          next if active_license.expired_date.blank?
          next unless active_license.expired_date <= now
          customer = school.customer_info
          next if customer.nil?
          next_plan = school.plan
          charge = Omise::Charge.create({
            amount: next_plan.price * 100,
            currency: "THB",
            description: "Automatic #{next_plan.package_name} renewal for the price of #{next_plan.price} Bath",
            customer: customer.id
          })

          new_license = License.create(
            plan_id: next_plan.id, expired_date: nil,
            charge_id: charge.id, school_id: school.id
          )
          new_license.fetch_charge_info('create')

          if charge.captured
            new_date_expire = next_plan.monthly? ? DateTime.now.utc+1.month : DateTime.now.utc+1.year
            new_license.update(expired_date: new_date_expire)
            renewal_schools += 1
          else
            error += 1
          end
        end
      end
      ap 'Done !'
      ap "Renew successfully total : #{renewal_schools}"
      ap "Cannot be renewed total : #{error}"
    end

  end