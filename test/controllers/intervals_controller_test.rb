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
    @user = users(:matias)
    sign_in @user
  end

  test 'should create interval' do
    post track_intervals_url(@track.id, locale: 'en'), params: {
      interval: {
        user_id: @user.id,
        track_id: @track.id,
        start_at: DateTime.now,
        end_at: 2.minutes.from_now
      }
    }

    assert_response :found
  end

  test 'should update interval' do
    patch track_interval_url(@track1.id, @interval.id, locale: 'en'), params: {
      interval: {
        end_at: DateTime.now
      }
    }

    assert_redirected_to track_url(@track1.id, locale: 'en')
  end

  test 'should delete interval' do
    delete track_interval_path(@track1.id, @interval.id, locale: 'en')
    assert_redirected_to track_path(@track1.id, locale: 'en')
  end
end
