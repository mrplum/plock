module Mutations
  # class IntervalEnd
  #
  class IntervalDestroy < BaseMutation
    argument :id, Int, required: true

    type Types::IntervalType

    def resolve(id:)
      interval = Interval.find(id)
      interval.destroy
    end
  end
end
