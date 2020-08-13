# frozen_string_literal: true

# ProjectsController class
#
class ProjectsController < ApplicationController
  include ConvertToHours
  before_action :set_project, only: [:show, :edit, :update, :destroy]
  before_action :set_project_api, only: [ :hours_members_team ]
  before_action :check_permissions, only: [ :edit, :update, :destroy]
  before_action :authenticate_user!

  # GET /projects
  # GET /projects.json
  def index
    @user = current_user
    @projects = @user.projects.uniq
  end

  # GET /projects/1
  # GET /projects/1.json
  def show
    @project = Project.find(params[:id])
    @tracks = @project.tracks
    @tracks_unstarted = @project.tracks.where(status: :unstarted)
    @tracks_in_progress = @project.tracks.where(status: :in_progress)
    @tracks_finished = @project.tracks.where(status: :finished)
  end

  # GET /projects/new
  def new
    @project = Project.new
  end

  # GET /projects/1/edit
  def edit
  end

  # POST /projects
  # POST /projects.json
  def create
    @project = Project.new(project_params.merge({
      user_id: current_user.id,
      company_id: current_user.company_id }))

    respond_to do |format|
      if @project.save
        flash[:success] = t('.success')
        format.html { redirect_to @project }
        format.json { render :show, status: :created, location: @project }
      else
        flash[:danger] = @project.errors.full_messages
        format.html { render :new }
        format.json { render json: @project.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /projects/1
  # PATCH/PUT /projects/1.json
  def update
    respond_to do |format|
      if @project.update(project_params)
        flash[:success] = t('.success')
        format.html { redirect_to @project }
        format.json { render :show, status: :ok, location: @project }
      else
        flash[:danger] = @project.errors.full_messages
        format.html { render :edit }
        format.json { render json: @project.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /projects/1
  # DELETE /projects/1.json
  def destroy
    @project.destroy
    respond_to do |format|
      flash[:success] = t('.success')
      format.html { redirect_to projects_url }
      format.json { head :no_content }
    end
  end

  def hours_members_team
    render json: get_hours_members_team
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_project
      @project = Project.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def project_params
      params[:project][:team_ids] = params.dig(:project, :team_ids).to_a.reject(&:empty?).map(&:to_i).compact

      params.require(:project).permit(:name, :description, :cost, :start_at, team_ids: [])
    end

    def check_permissions
      unless @project.user_id == current_user.id
        redirect_to projects_path, flash: { danger: 'Not authorized!' }
      end
    end

    def set_project_api
      @project = Project.find(params[:m_id])
    end

    def get_hours_members_team
      users_team = @project.team.users
      user_ids = users_team.ids
      user_names = users_team.pluck(:name)
      user_ids.map.with_index do |user_id, index|
        service = Elasticsearch::DataStatistics.new({'user_id': user_id, 'team_id': @project.team_id })
        {
          name: user_names[index],
          time: convert_to_hours(service.minutes_total.time_worked.value)
        }
      end
    end
end
