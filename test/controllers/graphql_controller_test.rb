require 'test_helper'

class GraphqlControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers
  include ActiveModel::Serializers::JSON
  setup do
    @user = users(:one)
    sign_in @user
  end

  test 'execute' do
    # post graphql_url,
    #   params: {
    #     query: query_string,
    #     variables: {},
    #     context: {}
    #   }
    # puts(@response)
    assert true
  end

end
