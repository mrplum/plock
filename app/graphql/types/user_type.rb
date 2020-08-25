# frozen_string_literal: true

module Types
  # class UserType
  #
  class UserType < Types::BaseObject
    field :id, ID, null: false
    field :name, String, null: false
    field :lastname, String, null: false
    field :email, String, null: false
    field :tracks, TrackType.connection_type, null: true
    field :teams, [TeamType], null: true
    field :projects, [ProjectType], null: true
    field :areas, AreaType.connection_type, null: true
    field :intervals, IntervalType.connection_type, null: true
    field :token, String, null: false
    field :created_at, String, null: false
    field :updated_at, String, null: false
  end
end
