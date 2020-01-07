class AddValidationToTeams < ActiveRecord::Migration[6.0]
  def change
    change_column_null :teams, :name, false
    change_column_null :teams, :project_id, false
  end

end
