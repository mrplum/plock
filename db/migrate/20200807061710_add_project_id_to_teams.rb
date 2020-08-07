class AddProjectIdToTeams < ActiveRecord::Migration[6.0]
  def change
    change_table :teams do |t|
      t.belongs_to :project
    end
  end
end
