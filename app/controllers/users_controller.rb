class UsersController < ApplicationController
  before_action :authenticate_user!

  def show
      @user = current_user
      @projects = @user.projects
  end

  def edit
    @user = User.find(params[:id])
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

  def dataUser
    render json: current_user.tracks.map {|track| {
      task: track.name,
      hour: track.plock_time }
    }.reject(&:empty?)  
  end 
    
  private
    def user_params
      params.require(:user).permit(:name, :lastname, :password, :reset_password_token, :password_confirmation)
    end

end