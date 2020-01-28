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

    field :projects,
      [ProjectType],
      null: true,
      description: 'Returns a list of projects created by the user registered in plock'
    def projects
      current_user&.projects
    end
  end
end
