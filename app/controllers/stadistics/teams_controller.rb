class Stadistics::TeamsController < ApplicationController
  def teams_table
    render json: Team.all
  end

  def index
    @record = 'teams'
    render 'stadistics/index'
  end

  def new
    @model = Team.new
    render 'stadistics/new'
  end

  def edit
    render 'stadistics/edit'
  end

  def create
  end

  def update
  end

  def destroy
  end
end