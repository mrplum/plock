# frozen_string_literal: true

module Types
  # class IntervalType
  #
  class IntervalType < Types::BaseObject
    field :id, Int, null: false
    field :track_id, Int, null: false
    field :user_id, Int, null: false
    field :created_at, String, null: false
    field :updated_at, String, null: false
    field :user, UserType, null: true
    field :track, TrackType, null: true
  end
end
