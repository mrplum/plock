class AddIncorporatedField < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :incorporated, :datetime
    change_table :users do |t|
      t.belongs_to :company
    end
  end
end
