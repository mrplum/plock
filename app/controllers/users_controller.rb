class UsersController < ApplicationController
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
        format.html { redirect_to @user, notice: 'Project was successfully updated.' }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  def data_user
    render json: current_user.tracks.map { |track|
      {
        name: track.name,
        time: track.plock_time
      }
    }.reject(&:empty?)
  end

  def hours_interval_time
    intervals = UserTracksStatIntervalTime.new(current_user, params[:interval]).call
    render json: intervals.map { |interval|
      {
        date: DateTime.parse(interval.key_as_string).try(:to_f)*1000,
        time: interval.time_worked.value
      }
    }.reject(&:empty?)
  end

  private
    def user_params
      params.require(:user).permit(:name, :lastname, :password, :reset_password_token,
                                   :password_confirmation, :avatar)
    end

end