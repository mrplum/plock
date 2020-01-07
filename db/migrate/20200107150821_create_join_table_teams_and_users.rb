class CreateJoinTableTeamsAndUsers < ActiveRecord::Migration[6.0]
  def change
    create_join_table :teams, :users
  end
end
