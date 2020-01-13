class UsersController < ApplicationController
    before_action :authenticate_user!

    def show
        @user = current_user
        @projects = @user.projects
    end

    def data
      array = [] 
      current_user.tracks.all.each do |track|
         array << {
          task: track.name,
          hour: calchs(track)
        } 
      end
      render json: array.to_a.reject(&:empty?).to_json
    end

    private
      def calchs (track)
        hs = ((track.ends_at - track.starts_at) / 3600).floor
        min = (((track.ends_at - track.starts_at) / 60) - (hs * 60)).floor
        return (hs.to_s+"."+min.to_s).to_f
      end
end