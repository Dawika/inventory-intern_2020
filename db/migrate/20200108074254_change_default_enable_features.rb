class ChangeDefaultEnableFeatures < ActiveRecord::Migration[5.0]
  def up
    change_column :site_configs, :enable_rollcall, :boolean, default: false
    change_column :school_settings, :enable_rollcall, :boolean, default: false
  end

  def down
    change_column :site_configs, :enable_rollcall, :boolean, default: true
    change_column :school_settings, :enable_rollcall, :boolean, default: true
  end
end
