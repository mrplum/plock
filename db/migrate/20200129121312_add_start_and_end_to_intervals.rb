class AddStartAndEndToIntervals < ActiveRecord::Migration[6.0]
  def change
    add_column :intervals, :start_at, :datetime
    add_column :intervals, :end_at, :datetime
  end
end
