class AddShowOnlyLineitemToSchoolSetting < ActiveRecord::Migration[5.0]
  def up
    add_column :school_settings, :show_only_lineitem, :bool, default: :false
  end

  def down
    remove_column :school_settings, :show_only_lineitem
  end
end
