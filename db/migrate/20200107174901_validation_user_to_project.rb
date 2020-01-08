class ValidationUserToProject < ActiveRecord::Migration[6.0]
  def change
    change_column_null :projects, :user_id, false
  end
end
