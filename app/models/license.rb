class License < ApplicationRecord
  default_scope { order('created_at desc') }

  belongs_to :school
  belongs_to :plan    
  has_one :charge_info

  def fetch_charge_info(action)
    return nil if self.charge_id.blank?
    charge = (Omise::Charge.retrieve(self.charge_id) rescue nil)
    if charge.present?
      card = charge.card
      charge_info = action == 'create' ? ChargeInfo.new : self.charge_info
      charge_info.amount = charge.amount / 100
      charge_info.currency = charge.currency
      charge_info.description = charge.description
      charge_info.captured = charge.captured
      charge_info.transaction_id = (charge.transaction.id rescue '')
      charge_info.card_brand = (card.brand rescue '')
      charge_info.card_last_digits = (card.last_digits rescue '')
      charge_info.failure_code = charge.failure_code
      charge_info.failure_message =  charge.failure_message
      charge_info.license_id = self.id
      charge_info.save
    end
    return charge
  end

end