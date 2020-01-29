class ProjectUserStat
  def initialize(user)
    @user = user
  end

  def call
    @user.tracks.sum(&:plock_time)
  end
end    
