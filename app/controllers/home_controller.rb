class HomeController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index], raise: false

  def index
    if current_user.present?
      @tracks = current_user.tracks
      @tracks_unstarted = @tracks.ordered_states(:unstarted)
      @tracks_progress = @tracks.ordered_states(:in_progress)
      @tracks_finished = @tracks.ordered_states(:finished)

      @header_state = build_state
    end
  end

  private

  def build_state
    [
      {
        name: t('.total_tracks'),
        count: @tracks.count,
        color: "primary",
        icon: 'fa-tasks'
      },
      {
        name: t('.unstarted_tracks'),
        count: @tracks_unstarted.count,
        color: "danger",
        icon: 'fa-times'
      },
      {
        name: t('.in_progress_tracks'),
        count: @tracks_progress.count,
        color: "warning",
        icon: 'fa-spinner'
      },
      {
        name: t('.finished_tracks'),
        count: @tracks_finished.count,
        color: "success",
        icon: 'fa-check'
      }
    ]
  end
end
