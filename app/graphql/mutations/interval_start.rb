module Mutations
  # class IntervalStart
  #
  class IntervalStart < BaseMutation
    argument :track_id, ID, required: true
    argument :user_id, ID, required: true
    argument :start_at, String, required: true
    argument :description, String, required: false

    type Types::IntervalType

    def resolve(track_id:, user_id:, start_at:, description:)
      Interval.create(track_id: track_id, user_id: user_id, start_at: start_at, end_at: start_at, description: description)
    end
  end
end