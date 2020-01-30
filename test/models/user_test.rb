require 'test_helper'

class UserTest < ActiveSupport::TestCase
  setup do
    # user belongs to project `one` through team `one`
    @project = projects(:one)
    @team = teams(:one)
    @user = users(:user_in_team_one)

    # user doesn't belongs to any team
    @user_without_team = users(:user_without_team)
  end

  test 'user belongs to @project' do
    assert @user.member_of? @project
  end

  test 'user doesn\'t belongs to @project' do
    assert_not @user_without_team.member_of? @project
  end
end
