class PurchasesController < ApplicationController

  def new
    @plans = Plan.all.order(id: 'asc')
    @school = current_user.school
  end

  def renew
    customer_token = params[:omise_token]
    if customer_token.present?
      current_user.school.bil_info.update(params_billing_info)
      plan = Plan.where(id: params[:school][:plan_id])
      # charge = Omise::Charge.create({
      #   amount: plan.price * 100,
      #   currency: "THB",
      #   description: "Automatic #{plan.package_name} renewal for the price of #{plan.price} Bath",
      #   customer: customer_token
      # })
      # update_license = current_user.school.active_license.update(
      #   plan_id: plan.id, expired_date: nil,
      #   charge_id: charge.id, school_id: current_user.school.id
      # )

      # if charge.captured
      #   new_date_expire = plan.monthly? ? DateTime.now.utc+1.month : DateTime.now.utc+1.year
      #   update_license.update(expired_date: new_date_expire)
      #   ap "sent email"
      # else
      #   ap "ERROR ! #{charge.failure_message} ( #{charge.failure_code} )"
      # end
    end
  end

  def update_card
    token = params[:omise_token]
    @customer = current_user.school.customer_info
    if @customer.default_card.present?
      default_card = @customer.cards.retrieve(@customer.default_card.id)
      default_card.destroy
    end
    @customer.update(card: token)
  end

  def params_billing_info
    params.require(:school).require(:bil_info_attributes).permit(
      :name, :address, :district, :province, :zip_code, :phone, :tax_id, :branch)
  end
end