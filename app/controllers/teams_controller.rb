# frozen_string_literal: true

# TeamsController class
class TeamsController < ApplicationController
  before_action :set_team, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!

  # GET /teams
  # GET /teams.json
  def index
    @teams = Team.all
  end

  # GET /teams/1
  # GET /teams/1.json
  def show
    @team = Team.find(params[:id])
  end

  # GET /teams/new
  def new
    @team = Team.new
  end

  # GET /teams/1/edit
  def edit
    # edit
  end

  # POST /teams
  # POST /teams.json
  def create

    @team = Team.new(team_params)

    respond_to do |format|
      if @team.save
        TeamUser.create(team_id: @team.id,user_id: current_user.id, incorporated_at: DateTime.now)
        @team.users.each { |user|
          UserMailer.with(user: user, team: @team).welcome_email.deliver_later
        }
        format.html do
          redirect_to @team, notice: 'Team was successfully created.'
        end
        format.json do
          render :show, status: :created, location: @team
        end
      else
        format.html { render :new }
        format.json do
          render json: @team.errors, status: :unprocessable_entity
        end
      end
    end
  end

  # PATCH/PUT /teams/1
  # PATCH/PUT /teams/1.json
  def update
    respond_to do |format|
      if @team.update(team_params)
        format.html do
          redirect_to @team, notice: 'Team was successfully updated.'
        end
        format.json { render :show, status: :ok, location: @team }
      else
        format.html { render :edit }
        format.json do
          render json: @team.errors, status: :unprocessable_entity
        end
      end
    end
  end

  # DELETE /teams/1
  # DELETE /teams/1.json
  def destroy
    @team.destroy
    respond_to do |format|
      format.html do
        redirect_to teams_url,
        notice: 'Team was successfully destroyed.'
      end
      format.json { head :no_content }
    end
  end

  def accept_invitation
    team_id = params[:team_id]
    user_id = params[:user_id]
    team_user = TeamUser.find_by(team_id: team_id, user_id: user_id)
    team_user.update(incorporated_at: DateTime.now)
    redirect_to new_user_session_path
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

    params.require(:team).permit(:name, user_ids: [])
  end
end
