class AddEnableVacationToSetting < ActiveRecord::Migration[5.0]
  def change
  	add_column :site_configs, :enable_vacation, :boolean, default: false
  	add_column :school_settings, :enable_vacation, :boolean, default: false
  end
end
