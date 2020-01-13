class CreateCompanies < ActiveRecord::Migration[6.0]
  def change
    create_table :companies do |t|
      t.string :name
      t.string :description
      t.belongs_to :user, null: false

      t.timestamps
    end
  end
end
