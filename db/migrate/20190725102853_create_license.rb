class CreateLicense < ActiveRecord::Migration[5.0]
  def change
    create_table :licenses do |t|
      t.timestamps
    end
  end
end
