module Mutations
  # class IntervalStart
  #
  class TrackCreate < BaseMutation
    argument :project_id, ID, required: true
    argument :team_id, ID, required: true
    argument :user_id, ID, required: true
    argument :name, String, required: true
    argument :description, String, required: true

    type Types::TrackType

    def resolve(project_id:, team_id: ,user_id:, name:, description:)
      Track.create(
        project_id: project_id,
        team_id: team_id,
        user_id: user_id,
        name: name,
        description: description
      )
    end
  end
end
