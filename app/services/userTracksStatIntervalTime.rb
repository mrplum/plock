class UserTracksStatIntervalTime
  def initialize(user, interval)
    @user = user
    @interval = interval
  end

  def call
    Interval.search_plock_time_by_interval_time(@user.id, @interval)
  end
end
