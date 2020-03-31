class StatusTracksStat
  def initialize(user)
    @user = user
  end

  def call
    Track.search_by_status(@user.id)
  end
end
