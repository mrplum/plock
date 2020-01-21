class CreateIntervals < ActiveRecord::Migration[6.0]
  def change
    create_table :intervals do |t|
      t.references :track

      t.timestamps
    end
  end
end
