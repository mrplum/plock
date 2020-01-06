class CreateTasks < ActiveRecord::Migration[6.0]
  def change
    create_table :Tasks do |t|
      t.string :name
      t.string :description
      t.datetime :starts_at
      t.datetime :end_at
      t.boolean :status

      t.timestamps
    end
  end
end
