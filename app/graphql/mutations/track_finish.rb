module Mutations
  # class IntervalStart
  #
  class TrackFinish < BaseMutation
    argument :id, ID, required: true
    argument :status, String, required: true

    type Types::TrackType

    def resolve(id:, status:)
      t = Track.find(id)
      t.update(status: status)
      return t
    end
  end
end