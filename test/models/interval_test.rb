# frozen_string_literal: true

require 'test_helper'

class IntervalTest < ActiveSupport::TestCase
  setup do
    @track = tracks(:one)
    @track1 = tracks(:two)
    @user = users(:one)
    @interval = intervals(:one)
  end

  test 'update plock time on update' do
    @interval.start_at = 2.hours.ago
    @interval.touch(:end_at)
    assert_equal(@interval.track.plock_time, 120)
  end

  test 'update plock time on destroy' do
    interval = intervals(:eight)
    track = interval.track

    assert_equal(30, track.plock_time)
    interval.destroy
    assert_equal(0, track.plock_time)
  end

  test 'update plock time with the sum of each interval' do
    # create an interval of two hours
    interval = Interval.create(description: 'test1', track: @track, user: @user, start_at: 2.hours.ago, end_at: DateTime.now)

    # create another interval of 1 hour
    interval = Interval.create(description: 'test2', track: @track, user: @user, start_at: 1.hour.ago, end_at: DateTime.now)

    # 3 hours as result
    assert_equal(@track.plock_time, 180)
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

  test 'interval not valid' do
    interval = intervals(:three)

    assert interval.valid_interval_dates?
  end

  test 'associated track is closed when close_track is on' do
    @interval.close_track = true
    @interval.save

    assert @interval.track.status == 'finished'
  end

  test 'associated track is NOT closed when close_track is off' do
    @interval.close_track = false
    @interval.save

    assert @interval.track.status != 'finished'
  end

  test 'associated track is closed when start_track is on' do
    @interval.start_track = true
    @interval.save

    assert @interval.track.status == 'in_progress'
  end

  test 'check interval in same day' do
    assert @interval.same_day?
  end

  test 'should update time' do
    interval = intervals(:two)
    interval.update(end_at: DateTime.now)
    assert_not_equal(0, interval.minutes)
  end

  # In case it is deleted, it is in_progress and has no intervals.
  test 'should update status' do
    interval = intervals(:six)
    track = interval.track

    assert_equal('in_progress', track.status)
    interval.destroy
    assert_equal('unstarted', track.status)
  end

  # In case it is deleted, it is finished and has no intervals.
  test 'should update status 1' do
    interval = intervals(:seven)
    track = interval.track

    assert_equal('finished', track.status)
    interval.destroy
    assert_equal('unstarted', track.status)
  end
end
