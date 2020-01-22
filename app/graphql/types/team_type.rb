# frozen_string_literal: true

module Types
  # class TeamType
  #
  class TeamType < Types::BaseObject
    field :id, ID, null: false
    field :name, String, null: false
    field :users, [UserType], null: true
    field :projects, [ProjectType], null: true
    field :created_at, String, null: false
    field :updated_at, String, null: false
  end
end