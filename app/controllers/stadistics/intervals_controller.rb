class Stadistics::IntervalsController < ApplicationController
  def intervals_table
    render json: Interval.all
  end

  def index
    @record = 'intervals'
    render 'stadistics/index'
  end

  def new
    @model = Interval.new
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