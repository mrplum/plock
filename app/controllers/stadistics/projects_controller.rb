class Stadistics::ProjectsController < ApplicationController
  def projects_table
    render json: Project.all
  end

  def index
    @record = 'projects'
    render 'stadistics/index'
  end

  def new
    @model = Project.new
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