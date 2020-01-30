class CreateTracks < ActiveRecord::Migration[6.0]
  def change
    create_table :tracks do |t|
      t.string :name, null: false
      t.string :description, null: false
      t.datetime :starts_at
      t.datetime :ends_at
      t.string :status, default: 'Unstarted'
      t.belongs_to :user, null: false
      t.belongs_to :project, null: false

      t.timestamps
    end
  end
end
