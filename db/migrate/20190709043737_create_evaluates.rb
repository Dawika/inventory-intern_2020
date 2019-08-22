class CreateEvaluates < ActiveRecord::Migration[5.0]
  def change
    create_table :evaluates do |t|
      t.integer :frontend, default: 0
      t.integer :dot_net, default: 0
      t.integer :dot_net_core, default: 0
      t.integer :ruby_on_rails, default: 0
      t.integer :kotlin, default: 0
      t.integer :swift, default: 0
      t.string :other_ability
      t.integer :problem_solving, default: 0
      t.integer :indepentdent, default: 0
      t.integer :comunication, default: 0
      t.integer :attention, default: 0
      t.boolean :on_time
      t.integer :teamwork, default: 0
      t.integer :compatibility, default: 0
      t.string :note
      t.string :glad
      t.boolean :is_submit
      t.references :interview, foreign_key: true
      t.references :interviewer_email, foreign_key: true

      t.timestamps
    end
  end
end
