module Mutations
  # class IntervalEnd
  #
  class IntervalEnd < BaseMutation
    argument :id, ID, required: true
    argument :end_at, String, required: true

    type Types::IntervalType

    def resolve(id:, end_at:)
      i = Interval.find(id)
      i.update(end_at: end_at)
      return i
    end
  end
end