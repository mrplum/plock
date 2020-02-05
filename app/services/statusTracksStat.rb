class StatusTracksStat
  def initialize(user)
    @user = user
  end

  def call
    @user.tracks.group(:status).count
  end
end
