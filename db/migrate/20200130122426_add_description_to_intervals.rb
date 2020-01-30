class AddDescriptionToIntervals < ActiveRecord::Migration[6.0]
  def change
    add_column :intervals, :description, :string, default: ''
  end
end
