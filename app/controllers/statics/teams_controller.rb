class Statics::TeamsController < ApplicationController
  def teams_table
    render json: Team.all
  end

  def index
    @record = 'teams'
    render 'statics/index'
  end

  def new
    @model = Team.new
    render 'statics/new'
  end

  def edit
    render 'statics/edit'
  end

  def create
  end

  def update
  end

  def destroy
  end
end