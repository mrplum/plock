# frozen_string_literal: true

# class IntervalsController
# 
class IntervalsController < ApplicationController
  before_action :authenticate_user!
  before_action :get_interval, only: [:update, :destroy]
  before_action :check_owner_interval, only: [:destroy, :update]
  
  def create
    interval = Interval.new(interval_params.merge({user_id:current_user.id}))
    respond_to do |format|
      if interval.save
        format.html { redirect_to track_path(interval.track), notice: 'Interval was successfully created.' }
        format.json { redirect_to track_path(interval.track), status: :created, location: interval }
      else
        format.html { redirect_to track_path(interval.track), flash: {danger: interval.errors.full_messages.join('. ')}}
        format.json { render json: interval.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @interval.touch
        format.html { redirect_to track_path(@interval.track), notice: 'Interval was successfully updated.' }
        format.json { redirect_to track_path(@interval.track), status: :ok, location: interval }
      else
        format.html { redirect_to track_path(@interval.track), notice: interval.error }
        format.json { render json: @interval.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @interval.destroy
    respond_to do |format|
      format.html { redirect_to track_url(@interval.track), notice: 'Project was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    def interval_params
      params.permit(:track_id, :user_id)
    end

    def get_interval
      @interval = Interval.find(params[:id])
    end 

    def check_owner_interval
      interval = Interval.find(params[:id])
      if interval.user_id != current_user.id
        redirect_to track_path(params[:track_id]), flash: {danger: 'You do not have permission to clear the interval'}
      end
    end
end
