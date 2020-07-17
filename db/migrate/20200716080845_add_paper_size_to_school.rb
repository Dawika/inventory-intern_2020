class AddPaperSizeToSchool < ActiveRecord::Migration[5.0]
  def up
    add_column :schools, :print_paper_size, :string, default: "A4"
  end

  def down
    remove_column :schools, :print_paper_size
  end
end
