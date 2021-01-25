module Mutations
  # class IntervalStart
  #
  class TrackFinish < BaseMutation
    argument :id, ID, required: true
    argument :status, String, required: true

    type Types::TrackType

    def resolve(id:, status:)
      track = Track.find(id)
      track.update(status: status)
      track
    end
  end
end
