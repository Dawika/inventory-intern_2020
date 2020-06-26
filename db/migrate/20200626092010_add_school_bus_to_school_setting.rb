class AddSchoolBusToSchoolSetting < ActiveRecord::Migration[5.0]
  def up
    add_column :school_settings, :enable_schoolbus, :bool, default: false
    add_column :site_configs, :enable_schoolbus, :bool, default: false
  end

  def down
    remove_column :school_settings, :enable_schoolbus
    remove_column :site_configs, :enable_schoolbus
  end
end
