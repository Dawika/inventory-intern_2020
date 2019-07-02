class AddForeignKeyToInterviewer < ActiveRecord::Migration[5.0]
  def change
    add_reference :interviewer_emails, :interview, foreign_key: {to_table: :interviews}
  end
end
