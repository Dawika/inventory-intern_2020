class AddCompanyRegistrationNumberToBilInfo < ActiveRecord::Migration[5.0]
  def change
    add_column :bil_infos, :company_id, :string
  end
end
