# frozen_string_literal: true

module Types
  # class QueryType
  #
  class QueryType < Types::BaseObject
    include ConvertToHours

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

    field :stats_by_time_interval, [GraphQL::Types::JSON], null: false do
      argument :interval, String, required: true
    end
    def stats_by_time_interval(interval:)
      service = Elasticsearch::DataStatistics.new({ 'user_id': current_user.id })
      service.minutes_by_calendar_interval(interval)
    end

    field :stats_by_projects,
      [GraphQL::Types::JSON],
      null: true,
      description: 'hours worked per project'
    def stats_by_projects
      current_user.projects.map do |project|
        service = Elasticsearch::DataStatistics.new({ 'user_id': current_user.id, 'project_id': project.id })
        {
          name: project.name,
          time: to_hours(service.minutes_total['time_worked']['value'])
        }
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
