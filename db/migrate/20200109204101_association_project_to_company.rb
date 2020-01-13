class AssociationProjectToCompany < ActiveRecord::Migration[6.0]
  def change
    change_table :projects do |t|
      t.belongs_to :company
    end
  end
end
