class HomeController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index], raise: false

  def index
    if current_user.present?
      @tracks = current_user.tracks
      @tracks_unstarted = @tracks.ordered_states(:unstarted)
      @tracks_progress = @tracks.ordered_states(:in_progress)
      @tracks_finished = @tracks.ordered_states(:finished)
    end
  end
end
