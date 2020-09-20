# frozen_string_literal: true

# ProjectsController class
#
class ProjectsController < ApplicationController
  include ConvertToHours
  before_action :set_project, only: [:show, :edit, :update, :destroy]
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
    authorize @project
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
    authorize @project
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
        format.html { redirect_to modal_params.present? ? projects_path : new_project_path }
        format.json { render json: @project.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /projects/1
  # PATCH/PUT /projects/1.json
  def update
    authorize @project
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
    authorize @project
    @project.destroy
    respond_to do |format|
      flash[:success] = t('.success')
      format.html { redirect_to projects_url }
      format.json { head :no_content }
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_project
    @project = Project.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def project_params
    params[:project][:team_ids] = params.dig(:project, :team_ids).to_a.reject(&:empty?).map(&:to_i).compact

    params.require(:project).permit(:name, :description, :area_id, :cost, team_ids: [])
  end

  def modal_params
    params.require(:project).permit(:modal)
  end
end
