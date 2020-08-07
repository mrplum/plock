class AddDefaultValueToProjects < ActiveRecord::Migration[6.0]
  def change
    change_column_default :projects, :cost, 1.00
  end
end
