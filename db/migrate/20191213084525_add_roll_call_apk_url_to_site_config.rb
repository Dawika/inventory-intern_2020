class AddRollCallApkUrlToSiteConfig < ActiveRecord::Migration[5.0]
  def change
  	add_column :site_configs, :roll_call_apk_url, :string
  end
end
