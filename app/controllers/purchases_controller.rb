class PurchasesController < ApplicationController

  def new
    @plans = Plan.all.order(id: 'asc')
    @school = current_user.school
    @school.build_bil_info if @school.bil_info.blank?
  end

  def renew
    school = current_user.school
    school.update(plan_id: params[:school][:plan_id])
    plan = school.plan
    if params[:school][:bil_info_attributes][:payment_method] == 'credit'
      token = params[:omise_token]
      if school.customer_id.blank?
        customer = Omise::Customer.create({
          email: school.email,
          description: "#{school.name_eng} (id: #{school.id})",
          card: token
        })
        school.customer_id = customer.id
        school.save
      end
      # update credit card ?
      if params[:update_card].present?
        customer_info = current_user.school.customer_info
        if customer_info.default_card.present?
          default_card = customer_info.cards.retrieve(customer_info.default_card.id)
          default_card.destroy
        end
        customer_info.update(card: token)
      end
      # auto subscribe = false
      if school.active_license.expired_date.present? and school.active_license.expired_date <= DateTime.now.utc
        charge = charge(plan, school)
        create_bil_info = BilInfo.new(params_billing_info.merge(school_id: school.id))
        create_bil_info.save(validate: false)
        school.licenses.create(
          plan_id: plan.id, expired_date: nil,
          charge_id: charge.id, school_id: school.id
        )
        school.active_license.fetch_charge_info('create')
        charge?(charge, plan, school)
      else # payment unsuccessful
        current_user.school.bil_info
        school.bil_info.update(params_billing_info)
        charge = charge(plan, school)

         school.active_license.update(
          plan_id: plan.id, expired_date: nil,
          charge_id: charge.id, school_id: school.id
        )
        school.active_license.fetch_charge_info('update')
        charge?(charge, plan, school)

      end
      
    end
  end

  def params_billing_info
    params.require(:school).require(:bil_info_attributes).permit(
      :name, :address, :district, :province, :zip_code, :phone, :tax_id, :branch)
  end

  def charge(plan, school)
    charge = Omise::Charge.create({
      amount: plan.price * 100,
      currency: "THB",
      description: "Automatic #{plan.package_name} renewal for the price of #{plan.price} Bath",
      customer: school.customer_id
    })
    return charge
  end

  def charge?(charge, plan, school)
    if charge.captured
      new_date_expire = plan.monthly? ? DateTime.now.utc + 1.month : DateTime.now.utc + 1.year
      school.active_license.update(expired_date: new_date_expire)
      redirect_to '/?success=true'
    else
      redirect_to '/'
    end
  end
end