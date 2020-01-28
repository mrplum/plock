class Statics::TracksController < ApplicationController
  def tracks_table
    render json: Track.all
  end

  def index
    @record = 'tracks'
    render 'statics/index'
  end

  def new
    @model = Track.new
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