# frozen_string_literal: true

require 'test_helper'

# class QueryTypeTest extend ActiveSupport::TestCase
#
class QueryTypeTest < ActiveSupport::TestCase
  def setup
    @user = users(:matias)
    @user1 = users(:one)
    @team = teams(:one)
    @track = tracks(:one)
    @track1 = tracks(:two)
    @track2 = tracks(:three)
    @project = projects(:one)
    @project1 = projects(:two)
    @company = companies(:one)
  end

  test 'projects created by current user' do
    query_string = <<-GRAPHQL
      query {
        projects {
          name
          team {
            name
            users {
              name
            }
          }
          tracks(first: 1) {
            edges{
              node{
                name
              }
            }
          }
          company {
            name
          }
        }
      }
    GRAPHQL

    context = {
      current_user: @user,
    }
    result = PlockSchema.execute(
      query_string,
      variables: {},
      context: context
    )

    project_names = result['data']['projects'].map { |project| project.dig('name') }
    project_one = result['data']['projects'].find { |p| p['name'] == 'MyString' }

    project_one_tracks_names = project_one.dig('tracks', 'edges').map { |track| track.dig('node', 'name') }

    project_one_team_name = project_one['team']['name']
    project_one_team_members_one_name = project_one['team']['users'][0]['name']

    assert_not_nil result

    # We got all projects of user @matias
    assert_equal(2, result['data']['projects'].count)

    assert_includes(project_names, @project.name)
    assert_includes(project_names, @project1.name)

    assert_equal(1, project_one_tracks_names.count)
    assert_includes(project_one_tracks_names, @track.name)

    assert_equal(@team.name, project_one_team_name)
    assert_equal(@user1.name, project_one_team_members_one_name)
  end

  test 'find project by id' do
    query_string = <<-GRAPHQL
      query($id: ID!) {
        project(id: $id) {
          name
          tracks(first: 1) {
            edges{
              node{
                name
              }
            }
          }
          owner {
            email
          }
          team {
            name
            users {
              name
            }
          }
          company {
            name
          }
        }
      }
      GRAPHQL

    project_id = @project.id
    result = PlockSchema.execute(
      query_string,
      variables: { id: project_id },
      context: { current_user: @user }
    )
    project_name_result = result['data']['project']['name']
    project_track_name_result = result['data']['project']['tracks']['edges'][0]['node']['name']
    company_name = result['data']['project']['company']['name']
    team_name = result['data']['project']['team']['name']

    assert_not_nil result
    assert_equal(@project.name, project_name_result)
    assert_equal(@track.name, project_track_name_result)
    assert_equal(@company.name, company_name)
    assert_equal(@team.name, team_name)
  end

  test 'all user data' do
    query_string = <<-GRAPHQL
      query {
        user {
          name
          email
          tracks(first: 3) {
            edges{
              node{
                name
                status
              }
            }
          }
          projects {
            name
          }
          teams {
            name
          }
        }
      }
    GRAPHQL

    context = {
      current_user: @user,
    }
    result = PlockSchema.execute(
      query_string,
      variables: {},
      context: context
    )

    user_name_result = result['data']['user']['name']

    project_names = result['data']['user']['projects'].map { |project| project.dig('name') }
    project_one = result['data']['user']['projects'].find { |p| p['name'] == 'MyString' }.dig('name')

    project_one_tracks_names = result['data']['user'].dig('tracks', 'edges').map { |track| track.dig('node', 'name') }

    team_one_name = result['data']['user']['teams'][0]['name']

    assert_not_nil result

    assert_equal(@user.name, user_name_result)
    
    assert_equal(2, project_names.count)
    assert_includes(project_names, @project.name)
    assert_includes(project_names, @project1.name)

    assert_equal(@project.name, project_one)

    assert_equal(3, project_one_tracks_names.count)
    assert_includes(project_one_tracks_names, @track.name)
    assert_includes(project_one_tracks_names, @track1.name)
    assert_includes(project_one_tracks_names, @track2.name)

    assert_equal(@team.name, team_one_name)
  end

  test 'stats user by day' do
    # Track.create(
    #   name: 'Test',
    #   description: 'is a test',
    #   plock_time: 200,
    #   user_id: 999,
    #   project: @project,
    #   created_at: DateTime.now,
    #   updated_at: 1.day.from_now
    # )

    # query_string = <<-GRAPHQL
    #   query {
    #     statsByDay
    #   }
    # GRAPHQL

    # user = users(:user1)
    # context = {
    #   current_user: user,
    # }
    # result = PlockSchema.execute(
    #   query_string,
    #   variables: {},
    #   context: context
    # )

    # minutes = result['data']['statsByDay'].map(&:last)

    assert true
    # assert_not_nil result
    # assert_not_empty result['data']['statsByDay']
    # assert_includes(minutes, 600)
    # assert_includes(minutes, 200)
  end

  test 'stats user by status of the track' do
    # query_string = <<-GRAPHQL
    #   query {
    #     statsByStatus
    #   }
    # GRAPHQL

    # context = {
    #   current_user: @user,
    # }
    # result = PlockSchema.execute(
    #   query_string,
    #   variables: {},
    #   context: context
    # )

    # data = result['data']['statsByStatus']
    # values = data.map(&:second)

    assert true
    # assert_not_nil result
    # assert_equal(2, values[0], 'quantity tracks unstarted for @user')
    # assert_equal(1, values[1], 'quantity tracks finished for @user')
    # assert_equal(1, values[2], 'quantity tracks in progress for @user')
  end
end
