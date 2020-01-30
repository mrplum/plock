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
    @interval.start_at = 2.hours.ago
    @interval.touch(:end_at)
    assert_equal(@interval.track.plock_time, 120)
  end

  test 'update plock time with the sum of each interval' do
    # create an interval of two hours
    interval = Interval.create(track: @track, user: @user, start_at: 2.hours.ago, end_at: DateTime.now)

    # create another interval of 1 hour
    interval = Interval.create(track: @track, user: @user, start_at: 1.hour.ago, end_at: DateTime.now)

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

  test 'start not valid' do
    @interval.track.project.start_at = Date.parse('2020-01-01')
    @interval.start_at = Date.parse('2020-02-01')
    assert @interval.valid_start_date?
  end

  test 'interval not valid' do
    interval = intervals(:three)

    assert interval.valid_interval_dates?
  end

  test 'associated track is closed when close_track is on' do
    @interval.close_track = true
    @interval.save

    assert @interval.track.status == 'Finished'
  end

  test 'associated track is NOT closed when close_track is off' do
    @interval.close_track = false
    @interval.save

    assert @interval.track.status != 'Finished'
  end

  test 'associated track is closed when start_track is on' do
    @interval.start_track = true
    @interval.save

    assert @interval.track.status == 'In progress'
  end
end
