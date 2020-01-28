class ChangeColumnsNamesInProjectAndCompany < ActiveRecord::Migration[6.0]
  def change
    rename_column :users, :incorporated, :incorporated_at
    rename_column :team_users, :joined, :incorporated_at
  end
end
