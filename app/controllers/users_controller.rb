class UsersController < ApplicationController
  before_action :authenticate_user!

  def show
      @user = current_user
      @projects = @user.projects
  end

  def data
    render json: current_user.tracks.map {|track| {
      task: track.name,
      hour: UserTrackStat.new(track).call }
    }.reject(&:empty?)  
  end
  
  #  def calchs (track)
      #  difference = ((track.ends_at - track.starts_at)).to_i
      #  hours =  (difference / 1.hour)
      #  minutes = (difference / 1.minute) % 1.minute.to_i
      #  "#{hours}.#{minutes}".to_f
  #  end
end
