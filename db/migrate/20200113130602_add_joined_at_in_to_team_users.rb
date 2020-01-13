class AddJoinedAtInToTeamUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :team_users, :joined, :datetime
  end
end
