class DeleteEmailFromInterviews < ActiveRecord::Migration[5.0]
  def change
    remove_column :interviews, :email
    add_column :interviews, :type, :string
    change_column :interviews, :location, :string, default: "Banana Office"
  end
end
