require 'test_helper'

class ProjectUserStatTest < ActiveSupport::TestCase

    setup do
        @user = users(:matias)
    end

    test "service for count quantity tracks per state" do
      data = StatusTracksStat.new(@user).call
      values = data.map(&:second)

      assert_equal(2, values[0], 'quantity tracks unstarted for @user')
      assert_equal(1, values[1], 'quantity tracks finished for @user')
      assert_equal(1, values[2], 'quantity tracks in progress for @user')
    end
end