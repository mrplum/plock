# Track class is for model the differents tasks of each project
class TracksController < ApplicationController
  before_action :get_project, only: [:new, :create, :update]
  before_action :check_permissions, only: [:new, :create, :update]
  before_action :set_track, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!

  # GET /tracks
  # GET /tracks.json
  def index
    @tracks = Track.all
  end

  # GET /tracks/1
  # GET /tracks/1.json
  def show
    @track = Track.find(params[:id])
    @intervals = @track.intervals
  end

  # GET /tracks/new
  def new
    @track = Track.new
  end

  # GET /tracks/1/edit
  def edit
  end

  # POST /tracks
  # POST /tracks.json
  def create
    @track = Track.new(track_params.merge({user_id: current_user.id, project_id: params[:project_id]}))

    respond_to do |format|
      if @track.save
        format.html { redirect_to @track, notice: 'track was successfully created.' }
        format.json { render :show, status: :created, location: @track }
      else
        format.html { render :new }
        format.json { render json: @track.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /tracks/1
  # PATCH/PUT /tracks/1.json
  def update
    respond_to do |format|
      if @track.update(track_params)
        format.html { redirect_to @track, notice: 'track was successfully updated.' }
        format.json { render :show, status: :ok, location: @track }
      else
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
      format.html { redirect_to tracks_url, notice: 'Track was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_track
      @track = Track.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def track_params
      params.require(:track).permit(:name, :description, :plock_time, :status)
    end

    def get_project
      @project = current_user.projects.find_by(id: params[:project_id])
      if @project.nil?
        redirect_to track_path(params[:track_id]), flash: {danger: 'You do not have permission to clear the interval'}          
      end
    end

    def check_permissions
      unless @project.team_id.in?(current_user.teams.pluck(:id))
        redirect_to project_path(params[:project_id]), flash: {danger: 'Unathorized for create track!'}
      end
    end
end
