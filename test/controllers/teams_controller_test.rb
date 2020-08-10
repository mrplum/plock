# frozen_string_literal: true

require 'test_helper'

# TeamsControllerTest
class TeamsControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  setup do
    @team = teams(:one)
    @user = users(:one)
    sign_in @user
  end

  test 'should get index' do
    get teams_url(locale: 'en')
    assert_response :success
  end

  test 'should get new' do
    get new_team_url(locale: 'en')
    assert_response :success
  end

  test 'should create team' do
    post teams_url(locale: 'en'), params: { team: { name: 'Test team' } }

    assert_response :redirect
  end

  test 'should show team' do
    get team_url(@team, locale: 'en')
    assert_response :success
  end

  test 'should get edit' do
    get edit_team_url(@team, locale: 'en')
    assert_response :success
  end

  test 'should update team' do
    patch team_url(@team, locale: 'en'), params: { team: { name: 'Team updated' } }
    assert_redirected_to team_url(@team, locale: 'en')
  end

  test 'should destroy team' do
    assert_difference('Team.count', -1) do
      delete team_url(@team, locale: 'en')
    end

    assert_redirected_to teams_url(locale: 'en')
  end
end
