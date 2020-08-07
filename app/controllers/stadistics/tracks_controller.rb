class Stadistics::TracksController < ApplicationController
  def tracks_table
    render json: Track.all
  end

  def index
    @record = 'tracks'
    render 'stadistics/index'
  end

  def new
    @model = Track.new
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