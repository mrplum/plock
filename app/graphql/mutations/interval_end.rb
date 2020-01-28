module Mutations
  # class IntervalEnd
  #
  class IntervalEnd < BaseMutation
    argument :id, Int, required: true

    type Types::IntervalType

    def resolve(id:)
      i = Interval.find(id)
      i.update(updated_at: DateTime.now)
      return i
    end
  end
end