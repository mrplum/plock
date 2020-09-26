# frozen_string_literal: true

module Types
  # class ProjectType
  #
  class ProjectType < Types::BaseObject
    field :id, ID, null: false
    field :name, String, null: false
    field :description, String, null: false
    field :area, AreaType, null: true
    field :company, CompanyType, null: false
    field :owner, UserType, null: false
    field :team, TeamType, null: true
    field :users, [UserType], null: true
    field :teams, [TeamType], null: true
    field :tracks, TrackType.connection_type, null: true
    field :created_at, String, null: false
    field :updated_at, String, null: false

    def owner
      object.user
    end
  end
end
