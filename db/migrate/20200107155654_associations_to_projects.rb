class AssociationsToProjects < ActiveRecord::Migration[6.0]
  def change
    remove_column :projects, :user_id
    change_table :projects do |t|
      t.belongs_to :user
    end
  end
end
