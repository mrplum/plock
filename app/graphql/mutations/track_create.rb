module Mutations
  # class IntervalStart
  #
  class TrackCreate < BaseMutation
    argument :project_id, Int, required: true
    argument :user_id, Int, required: true
    argument :name, String, required: true
    argument :description, String, required: true

    type Types::TrackType

    def resolve(project_id:, user_id:, name:, description:)
      datetime = DateTime.now
      Track.create(project_id: project_id, user_id: user_id, name: name, description: description)
    end
  end
end