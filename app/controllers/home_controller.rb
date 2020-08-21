class HomeController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index], raise: false

  def index
    if current_user.present?
      @tracks = current_user.tracks
      @tracks_unstarted = @tracks.where(status: "unstarted")
      @tracks_progress = @tracks.where(status: "in_progress")
      @tracks_finished = @tracks.where(status: "finished")

      @projects = current_user.projects.uniq
    end
  end
end
