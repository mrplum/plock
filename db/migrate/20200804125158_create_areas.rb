class CreateAreas < ActiveRecord::Migration[6.0]
  def change
    create_table :areas do |t|
      t.string :name, null: false
      t.string :description
      t.string :location
      t.bigint :company_id
      t.timestamps
    end
  end
end
