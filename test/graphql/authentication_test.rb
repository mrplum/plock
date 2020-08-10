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
    token = bearer_token('test@example.com', '123123')['user']['token']

    assert(token.present?)
    assert_equal(token.class, String)
  end

  test 'failing login' do
    token = bearer_token('invalid@user.com', 'INVALID PASS')['errors']

    assert_equal(token, 'Auth error')
  end

  test "not logged user doesn't has results" do
    post graphql_path(locale: 'en'),
      params: { query: @query_string },
      headers: { 'Authorization' => "Bearer INVALID" }

    response_body = JSON.parse(response.body)

    assert_nil(response_body['data']['user'])
  end

  test 'logged user has results from query' do
    token = bearer_token('test@example.com', '123123')['user']['token']
    post graphql_path(locale: 'en'),
      params: { query: @query_string },
      headers: { 'Authorization' => "Bearer #{token}" }

    response_body = JSON.parse(response.body)
    assert_response :success


    assert_equal(response_body['data']['user']['name'], 'Test')
  end

  def bearer_token(email, password)
    query = <<-GRAPHQL
      mutation login($email: String!, $password: String!){
        login(email: $email, password: $password){
          user {
            token
          }
          errors
        }
      }
    GRAPHQL

    result = PlockSchema.execute(
      query,
      variables: {
        email: email,
        password: password
      }
    )

    result['data']['login']
  end
end
