require 'test_helper'

class IntervalTest < ActiveSupport::TestCase
  def setup
    @track = tracks(:two)
    @user = users(:one)
    @interval = intervals(:one)
    @interval1 = intervals(:two)
  end

  test 'associate with track' do
    track = @interval.track
    assert_not_nil track
    assert_equal(@track.name, track.name)
  end

  test 'associate with user' do
    user = @interval.user
    assert_not_nil user
    assert_equal(@user.name, user.name)
  end
end