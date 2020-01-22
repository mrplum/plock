module Mutations
  # class IntervalStart
  #
  class IntervalStart < BaseMutation
    argument :track_id, ID, required: true

    type Types::IntervalType

    def resolve(track_id:)
      Interval.create(track_id: track_id)
    end
  end
end