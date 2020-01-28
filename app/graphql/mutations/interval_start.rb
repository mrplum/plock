module Mutations
  # class IntervalStart
  #
  class IntervalStart < BaseMutation
    argument :track_id, Int, required: true
    argument :user_id, Int, required: true

    type Types::IntervalType

    def resolve(track_id:, user_id:)
      Interval.create(track_id: track_id, user_id: user_id)
    end
  end
end