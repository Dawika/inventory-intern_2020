class CreateInterviewerEmails < ActiveRecord::Migration[5.0]
  def change
    create_table :interviewer_emails do |t|
      t.string :email, null: false
    end
  end
end
