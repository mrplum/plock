class RenameAttributeRepositoryToProjects < ActiveRecord::Migration[6.0]
  def change
    rename_column :projects, :repository, :description
  end
end
