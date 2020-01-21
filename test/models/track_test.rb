require 'test_helper'

class TrackTest < ActiveSupport::TestCase
  def setup
    @user = users(:one)
    @project = projects(:one)
  end

  test 'You can save a track' do
    track = Track.new(
      name: 'asdasadfa',
      description: 'asd',
      plock_time: 225,
      user: @user,
      project: @project
    )
    assert track.valid?
  end
end
