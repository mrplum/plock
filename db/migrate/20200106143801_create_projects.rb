class CreateProjects < ActiveRecord::Migration[6.0]
  def change
    create_table :projects do |t|
      t.string :name
      t.string :repository
      t.decimal :cost
      t.date :start_at

      t.timestamps
    end
  end
end
