module Mutations
  # class IntervalEnd
  #
  class IntervalEnd < BaseMutation
    argument :id, ID, required: true
    argument :end_at, String, required: true

    type Types::IntervalType

    def resolve(id:, end_at:)
      interval = Interval.find(id)
      interval.update(end_at: end_at)
      interval
    end
  end
end