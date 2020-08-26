# Track class is for model the differents tasks of each project
class TracksController < ApplicationController
  before_action :get_track, only: [:show, :edit, :update, :destroy]
  before_action :get_team, only: [:create, :update]
  before_action :get_project, only: [:new, :create, :update, :destroy]
  before_action :check_permissions, only: [:new, :create, :update, :destroy]
  before_action :authenticate_user!

  # GET /tracks
  # GET /tracks.json
  def index
    @tracks = current_user.tracks.includes(:project, :team)
  end

  # GET /tracks/1
  # GET /tracks/1.json
  def show
    @track = Track.includes(:intervals => :user).find(params[:id])
  end

  # GET /tracks/new
  def new
    @track = Track.new
  end

  # GET /tracks/1/edit
  def edit; end

  # POST /tracks
  # POST /tracks.json
  def create
    if track_params[:project_id].present?
      @track = Track.new(track_params.merge({user_id: current_user.id}))
    else
      @track = Track.new(track_params.merge({user_id: current_user.id, project_id: @project&.id}))
    end
    respond_to do |format|
      if @track.save
        flash[:success] = t('.success')
        if modal_params.present?
          format.html { redirect_to @project.present? ? project_path(@track.project) : root_path }
          format.json { render :show, status: :created, location: @track }
        else
          format.html { redirect_to @track }
          format.json { render :show, status: :created, location: @track }
        end
      else
        flash[:danger] = @track.errors.full_messages
        if modal_params.present?
          format.html { redirect_to @project.present? ? project_path(@track.project) : root_path }
          format.json { render json: @track.errors, status: :unprocessable_entity }
        else
          format.html { render :new }
          format.json { render json: @track.errors, status: :unprocessable_entity }
        end
      end
    end
  end

  # PATCH/PUT /tracks/1
  # PATCH/PUT /tracks/1.json
  def update
    respond_to do |format|
      if @track.update(track_params)
        flash[:success] = t('.success')
        format.html { redirect_to @track }
        format.json { render :show, status: :ok, location: @track }
      else
        flash[:danger] = @track.errors.full_messages
        format.html { render :edit }
        format.json { render json: @track.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /tracks/1
  # DELETE /tracks/1.json
  def destroy
    @track.destroy
    respond_to do |format|
      flash[:success] = t('.success')
      format.html { redirect_to project_path(@project.id) }
      format.json { head :no_content }
    end
  end

  def data_tracks
    render json: StatusTracksStat.new(current_user).call
  end

  private
    # Never trust parameters from the scary internet, only allow the white list through.
    def track_params
      params.require(:track).permit(:id, :name, :description, :plock_time, :status, :project_id, :team_id)
    end

    def modal_params
      params.require(:track).permit(:modal)
    end

    # Use callbacks to share common setup or constraints between actions.
    def get_track
      @track = Track.find(params[:id])
    end

    def get_team
      @team = Team.find_by(id: track_params[:team_id])
    end

    def get_project
      @project = current_user.projects.find_by(id: params[:project_id])
      @project ||= @track&.project
    end

    def check_team_invitation
      TeamUser.where("team_id IN :teams", @project.team_ids)
        .find_by(user_id: current_user.id)
        .incorporated?
    end

    def check_user_memebership
      current_user.member_of?(@project) unless @project
    end

    def check_user_ownership
      Project.where(user_id: current_user).exists?
    end

    def check_permissions
      # This user doesn't have any project yet (not owner nor member)
      if !(check_user_ownership || check_user_memebership)
        redirect_to tracks_path, flash: { danger: 'You do not have any project' }

      # ToDo: I don't get the reason of this check
      # else  check_team_invitation
      #   redirect_to project_path(@project.id), flash: { danger: 'Not authorized!' }
      end
    end
end
