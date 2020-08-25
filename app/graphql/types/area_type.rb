# frozen_string_literal: true

module Types
  # class AreaType
  #
  class AreaType < Types::BaseObject
    field :id, ID, null: false
    field :name, String, null: false
    field :description, String, null: true
    field :location, String, null: true
    field :company, CompanyType, null: true
    field :projects, ProjectType.connection_type, null: true
  end
end
