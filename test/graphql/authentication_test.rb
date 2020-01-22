require 'test_helper'

class AuthenticationTest < ActionDispatch::IntegrationTest
  USER_EMAIL='test@example.com'
  USER_PASS='12341324'

  def setup
    @user = User.new(
      name: 'Test',
      lastname: 'Login',
      email: 'test@example.com',
      password: '123123')
    @user.company = Company.new(name: 'My Company')
    @user.save

    @query_string = <<-GRAPHQL
      query{
        user {
          id
          name
        }
      }
    GRAPHQL
  end

  test 'success login' do
    post graphql_path,
      params: { query: @query_string },
      headers: { 'Authorization' => "Bearer #{bearer_token}" }

		response_body = JSON.parse(response.body)
    assert_response :success
    assert_equal(response_body['data']['user']['name'], 'Test')
  end

  test "not logged user doesn't has results" do
    post graphql_path,
      params: { query: @query_string },
      headers: { 'Authorization' => "Bearer INVALID" }

    response_body = JSON.parse(response.body)

    assert_nil(response_body['data']['user'])
  end

  def bearer_token
    query = <<-GRAPHQL
      mutation login($email: String!, $password: String!){
        login(email: $email, password: $password){
          token
        }
      }
    GRAPHQL
    result = PlockSchema.execute(
      query,
      variables: {
        email: 'test@example.com',
        password: '123123'
      }
    )

    result['data']['login']['token']
  end
end
