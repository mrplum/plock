class ProjectUserStat
  def initialize(user,project)
    @user = user
    @project = project
  end

  def call
    @user.tracks.where(project_id: @project.id).sum(&:plock_time)
  end
end    
