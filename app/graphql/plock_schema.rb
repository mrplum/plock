# frozen_string_literal: true

# class PlockSchema
#
class PlockSchema < GraphQL::Schema
  query(Types::QueryType)
  mutation(Types::MutationType)
end
