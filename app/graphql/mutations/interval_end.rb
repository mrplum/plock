module Mutations
  # class IntervalEnd
  #
  class IntervalEnd < BaseMutation
    argument :id, ID, required: true
    argument :end_at, String, required: true
    argument :description, String, required: false

    type Types::IntervalType

    def resolve(id:, end_at:, description:)
      i = Interval.find(id)
      i.update(end_at: end_at, description: description)
      return i
    end
  end
end