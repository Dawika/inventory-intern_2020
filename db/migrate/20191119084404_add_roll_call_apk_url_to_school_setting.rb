class AddRollCallApkUrlToSchoolSetting < ActiveRecord::Migration[5.0]
  def change
  	add_column :school_settings, :roll_call_apk_url, :string
  end
end
