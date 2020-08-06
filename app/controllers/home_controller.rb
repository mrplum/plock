class HomeController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index], raise: false

  def index
    if current_user.present?
      @tracks = Track.where(status: "in_progress").
                      or(Track.where(status: "unstarted")).
                      where(user_id: current_user.id)
      @projects = {}
      current_user.projects.each{ |p|
        total = p.tracks.count
        if total == 0
          @projects[p.name] = 0
        else
          @projects[p.name] = (100 * p.tracks.where(status: "finished").count) / total
        end
      }
    end
  end
end
