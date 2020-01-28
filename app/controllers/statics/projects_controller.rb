class Statics::ProjectsController < ApplicationController
  def projects_table
    render json: Project.all
  end

  def index
    @record = 'projects'
    render 'statics/index'
  end

  def new
    @model = Project.new
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