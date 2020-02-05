# frozen_string_literal: true

module Types
  # class QueryType
  #
  class QueryType < Types::BaseObject
    def current_user
      context[:current_user]
    end

    field :project, ProjectType, null: true do
      description 'Find a Project by ID'
      argument :id, ID, required: true
    end
    def project(id:)
      Project.find(id)
    end

    field :user,
      UserType,
      null: true,
      description: 'all user data'
    def user
      current_user
    end

    field :stats_by_day,
      [GraphQL::Types::JSON],
      null: true,
      description: 'hours worked per day'
    def stats_by_day
      UserTracksStatByDay.new(current_user).call
    end

    field :stats_by_projects,
      [GraphQL::Types::JSON],
      null: true,
      description: 'hours worked per project'
    def stats_by_projects
      current_user.projects.map do |project| 
        name = project.name,
        time = ProjectUserStat.new(current_user, project).call
      end
    end

    field :stats_by_status,
      [GraphQL::Types::JSON],
      null: true,
      description: 'count quantity tracks per state'
    def stats_by_status
      StatusTracksStat.new(current_user).call
    end

    field :projects,
      [ProjectType],
      null: true,
      description: 'Returns a list of projects created by the user registered in plock'
    def projects
      current_user&.projects
    end
  end
end
