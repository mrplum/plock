class ValidationsForPojects < ActiveRecord::Migration[6.0]
  def change
    change_column_null :projects, :name, false
    change_column_null :projects, :repository, false
    change_column_null :projects, :cost, false
    add_index :projects, :name, unique: true
  end
end
