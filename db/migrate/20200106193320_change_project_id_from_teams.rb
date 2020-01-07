class ChangeProjectIdFromTeams < ActiveRecord::Migration[6.0]
  def self.up
    rename_column :teams, :proyect_id, :project_id
  end

  def self.down
    rename_column :teams, :project_id, :proyect_id
  end
end
