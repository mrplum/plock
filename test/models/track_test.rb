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
      starts_at: Date.new,
      end_at: Date.new,
      user: @user,
      project: @project
    )
    assert track.valid?
  end
end
