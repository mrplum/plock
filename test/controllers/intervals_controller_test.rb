# frozen_string_literal: true
require 'test_helper'

# IntervalsControllerTest class
#
class IntervalsControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  setup do
    @track = tracks(:one)
    @track1 = tracks(:two)
    @interval = intervals(:two)
    @user = users(:one)
    sign_in @user
  end

  test 'should create interval' do
    Interval.destroy_all
    post track_intervals_path(@track.id)
    assert_redirected_to track_path(@track.id)
  end

  test 'should update interval' do
    patch track_interval_path(@track1.id, @interval.id)
    assert_redirected_to track_path(@track1.id)
  end

  test 'should delete interval' do
    delete track_interval_path(@track1.id, @interval.id)
    assert_redirected_to track_path(@track1.id)
  end
end
