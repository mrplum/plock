class ChangesColumnsTracks < ActiveRecord::Migration[6.0]
  def change
    remove_column :tracks, :starts_at
    remove_column :tracks, :ends_at
    add_column :tracks, :plock_time, :integer
  end
end
