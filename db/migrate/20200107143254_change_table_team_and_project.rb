class ChangeTableTeamAndProject < ActiveRecord::Migration[6.0]
  def change
    add_column :projects, :team_id, :integer
    remove_column :teams, :project_id, :integer
  end
end
