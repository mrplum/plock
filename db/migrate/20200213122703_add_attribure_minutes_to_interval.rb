class AddAttribureMinutesToInterval < ActiveRecord::Migration[6.0]
  def change
    add_column :intervals, :minutes, :integer, default: 0
  end
end
