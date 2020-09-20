# frozen_string_literal: true

# TeamsController class
class TeamsController < ApplicationController
  include ConvertToHours
  before_action :set_team, only: [:show, :edit, :update, :destroy]
  before_action :set_data_api, only: [ :hours_to_projects, :hours_members_team ]
  before_action :authenticate_user!

  # GET /teams
  # GET /teams.json
  def index
    @user = current_user
    @teams = @user.teams
  end

  # GET /teams/1
  # GET /teams/1.json
  def show
    @team = Team.find(params[:id])
    authorize @team
  end

  # GET /teams/new
  def new
    @team = Team.new
  end

  # GET /teams/1/edit
  def edit
    authorize @team
  end

  # POST /teams
  # POST /teams.json
  def create
    @team = Team.new(team_params)

    respond_to do |format|
      if @team.save
        TeamUser.create(team_id: @team.id,user_id: current_user.id, incorporated_at: DateTime.now)
        @team.users.each do |user|
          UserMailer.welcome_email(user, @team).deliver
        end
        flash[:success] = t('.success')
        format.html { redirect_to @team }
        format.json { render :show, status: :created, location: @team }
      else
        flash[:danger] = @team.errors.full_messages
        format.html { render :new }
        format.json { render json: @team.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /teams/1
  # PATCH/PUT /teams/1.json
  def update
    authorize @team
    respond_to do |format|
      if @team.update(team_params)
        TeamUser.create(team_id: @team.id,user_id: current_user.id, incorporated_at: DateTime.now)
        @team.users.each do |user|
          UserMailer.welcome_email(user, @team).deliver
        end
        flash[:success] = t('.success')
        format.html { redirect_to @team }
        format.json { render :show, status: :ok, location: @team }
      else
        flash[:danger] = @team.errors.full_messages
        format.html { render :edit }
        format.json { render json: @team.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /teams/1
  # DELETE /teams/1.json
  def destroy
    authorize @team
    @team.destroy
    respond_to do |format|
      flash[:success] = t('.success')
      format.html { redirect_to teams_url }
      format.json { head :no_content }
    end
  end

  def accept_invitation
    team_id = params[:id]
    user_id = params[:user_id]
    team_user = TeamUser.find_by(team_id: team_id, user_id: user_id)
    team_user.update(incorporated_at: DateTime.now)
    redirect_to new_user_session_path
  end

  def hours_to_projects
    render json: get_hours_to_projects
  end

  def hours_members_team
    render json: get_hours_members_team
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_team
    @team = Team.find(params[:id])
  end

  # Never trust parameters from the scary internet,
  # only allow the white list through.
  def team_params
    params[:team][:user_ids] = params.dig(:team, :user_ids).to_a.reject(&:empty?).map(&:to_i).compact

    params.require(:team).permit(:name, :project_id, user_ids: [])
  end

  def set_data_api
    @team = Team.find(params[:m_id])
  end

  def get_hours_to_projects
    projects = @team.projects
    projects.map do |project|
      service = Elasticsearch::DataStatistics.new({ 'team_id': @team.id, 'project_id': project.id })
      {
        name: project.name,
        time: to_hours(service.minutes_total['time_worked']['value'])
      }
    end
  end

  def get_hours_members_team
    users = @team.users
    users.map do |user|
      service = Elasticsearch::DataStatistics.new({ 'team_id': @team.id, 'user_id': user.id })
      {
        name: "#{user.lastname}, #{user.name}",
        time: to_hours(service.minutes_total['time_worked']['value'])
      }
    end
  end
end

