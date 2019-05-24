class AddNameEngNoteSubdomainNameBranchSchoolSettingIdToSchools < ActiveRecord::Migration[5.0]
  def change
    add_column :schools, :name_eng, :string
    add_column :schools, :note, :string
    add_column :schools, :subdomain_name, :string
    add_column :schools, :branch, :string
  end
end
