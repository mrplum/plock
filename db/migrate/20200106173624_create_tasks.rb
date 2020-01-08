class CreateTasks < ActiveRecord::Migration[6.0]
  def change
    create_table :tasks do |t|
      t.string :name, null: false
      t.string :description, null: false
      t.datetime :starts_at
      t.datetime :end_at
      t.boolean :status, default: false
      t.belongs_to :user, null: false
      t.belongs_to :project, null: false

      t.timestamps
    end
  end
end
