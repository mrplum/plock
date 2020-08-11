class UsersController < ApplicationController
  include ConvertToHours
  before_action :authenticate_user!

  def show
    @user = current_user
    @projects = @user.projects
  end

  def edit
    @user = User.find(params[:id])
  end

  def stadistics
    @user = current_user
    @projects = @user.projects
  end

  def update
    @user = User.find(params[:id])
    respond_to do |format|
      if @user.update(user_params)
        flash[:success] = t('.success')
        format.html { redirect_to @user }
        format.json { render :show, status: :ok, location: @user }
      else
        flash[:danger] = @user.errors.full_messages
        format.html { render :edit }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  def data_user_in_tracks
    render json: time_in_tracks
  end

  def hours_interval_time
    render json: time_user_in_intervals
  end

  private

  def user_params
    params.require(:user).permit(:name, :lastname, :password, :reset_password_token,
                                  :password_confirmation, :avatar)
  end

  def time_in_tracks
    tracks = current_user.tracks
    track_ids = tracks.ids
    track_names = tracks.pluck(:name)
    data = track_ids.map.with_index do |track_id, index|
      service = Elasticsearch::DataStatistics.new({'user_id': current_user.id, 'track_id': track_id })
      {
        name: track_names[index],
        time: convert_to_hours(service.minutes_total.time_worked.value)
      }
    end
  end

  def time_user_in_intervals
    service = Elasticsearch::DataStatistics.new({'user_id': current_user.id})
    intervals = service.minutes_by_calendar_interval(params[:interval])
    data = intervals.collect do |interval|
      time = interval.time_worked.value
      {
        date: interval.key_,
        time: convert_to_hours(time)
      }
    end
  end
end