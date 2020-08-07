# frozen_string_literal: true

# ProjectsController class
#
class ProjectsController < ApplicationController
  before_action :set_project, only: [:show, :edit, :update, :destroy]
  before_action :check_permissions, only: [ :edit, :update, :destroy]
  before_action :authenticate_user!

  # GET /projects
  # GET /projects.json
  def index
    @user = current_user
    @projects = @user.projects
  end

  # GET /projects/1
  # GET /projects/1.json
  def show
    @project = Project.find(params[:id])
    @tracks = @project.tracks
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
    @project = Project.new(project_params.merge({ user_id: current_user.id, company_id: current_user.company_id }))

    respond_to do |format|
      if @project.save
        format.html { redirect_to @project, notice: 'Project was successfully created.' }
        format.json { render :show, status: :created, location: @project }
      else
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
        format.html { redirect_to @project, notice: 'Project was successfully updated.' }
        format.json { render :show, status: :ok, location: @project }
      else
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
      format.html { redirect_to projects_url, notice: 'Project was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def data_project
    @project = Project.find(params[:m_id])
    result = @project.teams.map(&:users).flatten.to_a.map do |user|
      {
        name: user.name,
        time: ProjectUserStat.new(user, @project).call
      }
    end
    render json: result.present? ? result : [].to_json
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
end
