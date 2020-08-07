class ProjectUserStat
  def initialize(user,project)
    @user = user
    @project = project
  end

  def call
    search_plock_time_given_user_and_project(@user.id, @project.id)
  end

  private

  def search_plock_time_given_user_and_project(user_id, project_id)
    Interval.__elasticsearch__.search({
      query: {
        bool: {
          must: [
            { term: { user_id: user_id } },
            { term: { project_id: project_id } }
          ]
        }
      },
      aggs: {
        time_worked: {
          sum: { field: 'minutes' }
        }
      }
    }).response['aggregations']['time_worked']['value'].to_i
  end
end