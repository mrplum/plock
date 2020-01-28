class AddUserToIntervals < ActiveRecord::Migration[6.0]
  def change
    change_table :intervals do |t|
      t.references :user
    end
  end
end
