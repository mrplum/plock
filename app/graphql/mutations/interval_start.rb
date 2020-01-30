module Mutations
  # class IntervalStart
  #
  class IntervalStart < BaseMutation
    argument :track_id, Int, required: true
    argument :user_id, Int, required: true

    type Types::IntervalType

    def resolve(track_id:, user_id:)
      datetime = DateTime.now
      Interval.create(track_id: track_id, user_id: user_id, start_at: datetime, end_at: datetime)
    end
  end
end