require 'test_helper'

class TrackTest < ActiveSupport::TestCase
  def setup
    @user = users(:one)
    @project = projects(:one)
    @track = tracks(:one)
    @track1 = tracks(:two)
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

    # (Case in which the interval was closed)
    test 'test of the validation open intervals' do
      assert_not @track.has_open_intervals?
    end
  
    # (Case in which the interval was not closed)
    test 'test of the validation  open intervals.' do
      assert @track1.has_open_intervals?
    end
end
