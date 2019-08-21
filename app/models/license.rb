class License < ApplicationRecord
  default_scope { order('created_at desc') }

  belongs_to :school
  belongs_to :plan    
  has_one :charge_info

  def fetch_charge_info
    return nil if self.charge_id.blank?
    charge = (Omise::Charge.retrieve(self.charge_id) rescue nil)
    if charge.present? && self.charge_info.nil?
      card = charge.card

      ChargeInfo.create(
        amount: charge.amount / 100,
        currency: charge.currency,
        description: charge.description,
        captured: charge.captured,
        transaction_id: (charge.transaction.id rescue ''),
        card_brand: (card.brand rescue ''),
        card_last_digits: (card.last_digits rescue ''),
        failure_code: charge.failure_code,
        failure_message:  charge.failure_message,
        license_id: self.id
      )
    end
    return charge
  end
end