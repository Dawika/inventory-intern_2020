class CreateChargeInfo < ActiveRecord::Migration[5.0]
  def change
    create_table :charge_infos do |t|
      t.integer "amount"
      t.string  "currency"
      t.string  "description"
      t.boolean "captured"
      t.string  "transaction_id"
      t.string  "card_brand"
      t.string  "card_last_digits"
      t.string  "failure_code"
      t.string  "failure_message"
    end
  end
end
