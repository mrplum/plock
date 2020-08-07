class AddAreaToProject < ActiveRecord::Migration[6.0]
  def up
    add_column :projects, :area_id, :integer
  end

  def down
    remove_column :projects, :area_id, :integer
  end
end
