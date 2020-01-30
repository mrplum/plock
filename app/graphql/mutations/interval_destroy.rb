module Mutations
  # class IntervalEnd
  #
  class IntervalDestroy < BaseMutation
    argument :id, Int, required: true

    type Types::IntervalType

    def resolve(id:)
      i = Interval.find(id)
      i.destroy
    end
  end
end