class AddReservedSubdomainsToSiteConfigs < ActiveRecord::Migration[5.0]
  def change
    add_column :site_configs, :reserved_subdomains, :string
  end
end
