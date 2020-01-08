class AssociationProjectToTeam < ActiveRecord::Migration[6.0]
  def change
    remove_column :projects, :team_id
    change_table :projects do |t|
      t.belongs_to :team
    end
  end
end
