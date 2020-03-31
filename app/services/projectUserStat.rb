class ProjectUserStat
  def initialize(user,project)
    @user = user
    @project = project
  end

  def call
    Track.search_plock_time_given_user_and_project(@user.id, @project.id).to_i
  end
end
