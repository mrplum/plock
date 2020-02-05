class UserTracksStatByDay
  def initialize(user)
    @user = user
  end

  def call
    @user.tracks.group('date(tracks.updated_at)').sum('tracks.plock_time')
  end
end
