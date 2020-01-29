# frozen_string_literal: true

require 'test_helper'

class IntervalTest < ActiveSupport::TestCase
  setup do
    @track = tracks(:one)
    @track2 = tracks(:two)
    @user = users(:one)
    @interval = intervals(:one)
  end

  test 'update plock time on update' do
    # interval = Interval.create(track: @track)
    @interval.created_at = 2.hours.ago
    @interval.touch
    # @interval.save
    # puts @interval.created_at
    # @interval.run_callbacks :update
    assert_equal(@interval.track.plock_time, 120)
  end

  test 'update plock time with the sum of each interval' do
    # craete an interval of two hours
    interval = Interval.create(track: @track, user: @user, created_at: 2.hours.ago)
    interval.touch

    # create another interval of 1 hour
    interval = Interval.create(track: @track, user: @user, created_at: 1.hour.ago)
    interval.touch

    # 3 hours as result
    assert_equal(@track.plock_time, 180)
  end

  test 'associate with track' do
    track = @interval.track
    assert_not_nil track
    assert_equal(@track2.name, track.name)
  end

  test 'associate with user' do
    user = @interval.user
    assert_not_nil user
    assert_equal(@user.name, user.name)
  end
end
