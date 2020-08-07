class AddTeamIdToTracks < ActiveRecord::Migration[6.0]
  def change
    change_table :tracks do |t|
      t.belongs_to :team
    end
  end
end
