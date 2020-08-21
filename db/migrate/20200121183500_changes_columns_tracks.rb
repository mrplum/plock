class ChangesColumnsTracks < ActiveRecord::Migration[6.0]
  def change
    remove_column :tracks, :starts_at, :datetime
    remove_column :tracks, :ends_at, :datetime
    add_column :tracks, :plock_time, :integer, default: 0
  end
end
