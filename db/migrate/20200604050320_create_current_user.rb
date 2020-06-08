class CreateCurrentUser < ActiveRecord::Migration[5.0]
  def change
    create_table :current_users do |t|
      t.string :current_user
    end
  end
end
