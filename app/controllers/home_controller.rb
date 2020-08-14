class HomeController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index], raise: false

  def index
    if current_user.present?
      @tracks = current_user.tracks
      @tracks_unstarted = @tracks.where(status: "unstarted")
      @tracks_progress = @tracks.where(status: "in_progress")
      @tracks_finished = @tracks.where(status: "finished")

      tracks_unfinished = @tracks_unstarted.merge(@tracks_progress).pluck(:project_id)
      @projects_unfinished = {}
      tracks_unfinished.uniq.each { |p_id|
        project = Project.find_by(id: p_id)
        @projects_unfinished[project.name] = [project, tracks_unfinished.count(p_id)]
      }

      @projects = {}
      current_user.projects.each { |project|
        total = project.tracks.count
        finished = project.tracks.where(status: "finished").count
        if total == 0
          @projects[project.name] = 0
        else
          @projects[project.name] = (100 * finished) / total
        end
      }
    end
  end
end
