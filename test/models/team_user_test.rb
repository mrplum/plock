require 'test_helper'

class TeamUserTest < ActiveSupport::TestCase
  def setup
    @team_user = team_users(:one)
  end

  test "incorporated?" do
    assert @team_user.incorporated?
  end
end
