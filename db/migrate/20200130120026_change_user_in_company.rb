class ChangeUserInCompany < ActiveRecord::Migration[6.0]
  def change
    rename_column :companies, :user_id, :owner_id
  end
end
