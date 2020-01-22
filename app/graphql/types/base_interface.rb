# frozen_string_literal: true

module Types
  # class BaseInterface
  #
  module BaseInterface
    include GraphQL::Schema::Interface

    field_class Types::BaseField
  end
end
