class AddEnableScoutToSiteConfig < ActiveRecord::Migration[5.0]
  def change
    add_column :site_configs, :enable_scout, :boolean, default: false
  end
end
