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

  def remove_avatar
    user = User.find params[:id]
    user.update(avatar: nil)
    redirect_to edit_user_path(user)
  end

  def calendar
    @user = current_user
  end

  def events
    render json: user_events
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
        time: to_hours(service.minutes_total['time_worked']['value'])
      }
    end
  end

  def time_user_in_intervals
    service = Elasticsearch::DataStatistics.new({'user_id': current_user.id})
    intervals = service.minutes_by_calendar_interval(params[:interval])
    data = intervals.collect do |interval|
      {
        date: interval['key_as_string'],
        time: to_hours(interval['time_worked']['value'])
      }
    end
  end

  def user_events
    data = []
    intervals = Interval.where(user_id: current_user.id)
    intervals.each { |interval|
      start_at = interval.start_at.strftime("%F")
      end_at = interval.end_at.strftime("%F")
      start_at_time = interval.start_at.strftime("%T")
      end_at_time = interval.end_at.strftime("%T")
      if interval.open?
        data << {
          title: interval.track.name,
          start: start_at,
          description: interval.description,
          start_at_time: start_at_time,
          project: interval.track.project.name
        }
      else
        data << {
          title: interval.track.name,
          start: start_at,
          end: end_at,
          description: interval.description,
          start_at_time: start_at_time,
          end_at_time: end_at_time,
          project: interval.track.project.name
        }
      end
    }
    data
  end
end