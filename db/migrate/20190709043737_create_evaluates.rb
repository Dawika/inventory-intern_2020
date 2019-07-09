class CreateEvaluates < ActiveRecord::Migration[5.0]
  def change
    create_table :evaluates do |t|
      t.integer :frontend, default: 0
      t.integer :dot_net, default: 0
      t.integer :dot_net_core, default: 0
      t.integer :ruby_on_rails, default: 0
      t.integer :kotlin
      t.integer :swift
      t.string :other_ability
      t.integer :problem_solving
      t.integer :indepentdent
      t.integer :comunication
      t.integer :attention
      t.boolean :on_time
      t.integer :teamwork
      t.integer :compatibility
      t.string :note
      t.string :glad
      t.boolean :is_submit
      t.references :interview, foreign_key: true
      t.references :interviewer_email, foreign_key: true

      t.timestamps
    end
  end
end
