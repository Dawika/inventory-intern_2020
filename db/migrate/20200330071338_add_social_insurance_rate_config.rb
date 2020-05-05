class AddSocialInsuranceRateConfig < ActiveRecord::Migration[5.0]
  def change
  	add_column :site_configs, :social_insurance_rate, :float, default: 0.05
  	add_column :school_settings, :social_insurance_rate, :float, default: 0.05
  end
end
