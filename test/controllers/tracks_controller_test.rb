require 'test_helper'

class TracksControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers
  setup do
    @track = tracks(:one)
    @track1 = tracks(:two)
    @user = users(:matias)
    @project = projects(:one)
    sign_in @user
  end

  test 'should get index' do
    get tracks_url(locale: 'en')
    assert_response :success
  end

  test 'should get new' do
    get new_track_url(locale: 'en'), params: { project_id: @project.id }
    assert_response :success
  end

  test 'should create track' do
    post tracks_url(locale: 'en'), params: {
      project_id: @project.id,
      track: {
        description: @track.description,
        name: @track.name,
        status: @track.status,
        plock_time: @track.plock_time,
        project: @project
      }
    }
    assert_response :success
  end

  test 'should show track' do
    get track_url(@track, locale: 'en')
    assert_response :success
  end

  test 'should get edit' do
    get edit_track_url(@track, locale: 'en')
    assert_response :success
  end

  test "should update track" do
    patch track_url(@track, locale: 'en'), params: {
      project_id: @project.id,
      track: {
        description: @track.description,
        name: @track.name,
        status: @track.status,
        plock_time: @track.plock_time,
        project: @project
      }
    }
    assert_response :success
  end

  test 'should destroy track' do
    assert_difference('Track.count', -1) do
      delete track_url(@track.id, locale: 'en'), params: {
        project_id: @project.id,
        track: {
          description: @track.description,
          name: @track.name,
          status: @track.status,
          plock_time: @track.plock_time,
          project: @project
        }
      }
    end
    assert_redirected_to project_url(@project.id, locale: 'en')
  end
end
