# frozen_string_literal: true

# class IntervalsController
# 
class IntervalsController < ApplicationController
  before_action :authenticate_user!
  before_action :get_track, only: [:new, :update]
  before_action :check_owner_track, only: [:create]
  before_action :get_interval, only: [:update, :destroy]
  before_action :check_owner_interval, only: [:destroy, :update]

  def new
    @interval = @track.intervals.build(user_id: current_user.id)
  end

  def create
  
    start_at = params[:start_at] || DateTime.now
    end_at = params[:end_at] || start_at
 
    interval = interval_params.merge({
      user_id: current_user.id,
      track_id: params[:track_id],
      start_at: start_at,
      end_at: end_at
    })
 
    interval = Interval.new(interval)

    respond_to do |format|
      if interval.save
        format.json do
          track = Track.includes(:intervals => :user).find(params[:track_id])
          render partial: "tracks/track_interval.html.erb", locals: {track: track} 
        end
        format.js { 'ok' }
        format.html { redirect_to track_path(interval.track), notice: 'Interval was successfully created.' }
      else
        format.html { redirect_to track_path(interval.track), flash: {danger: interval.errors.full_messages.join('. ')}}
        format.json { render json: interval.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @interval.update(interval_params.merge({end_at: DateTime.now}))
        format.json do
          track = Track.includes(:intervals => :user).find(params[:track_id])
          render partial: "tracks/track_interval.html.erb", locals: {track: track} 
        end
        format.html { redirect_to track_path(@interval.track), notice: 'Interval was successfully updated.' }
        format.js { "ok" }
      else
        format.html { redirect_to track_path(@interval.track), notice: @interval.error }
        format.json { render json: @interval.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @interval.destroy
    respond_to do |format|
      format.json do
        track = Track.includes(:intervals => :user).find(params[:track_id])
        render partial: "tracks/track_interval.html.erb", locals: {track: track} 
      end
      format.html { redirect_to track_url(@interval.track), notice: 'Project was successfully destroyed.' }
    end
  end

  private
    def interval_params
      params.require(:interval)
        .permit(:track_id, :user_id, :start_at, :end_at, :description, :close_track, :start_track)
    end

    def get_track
      @track = Track.find(params[:track_id])
    end

    def get_interval
      @interval = @track&.open_interval || Interval.find(params[:id])
    end 

    def check_owner_interval
      interval = Interval.find(params[:id])
      if interval.user_id != current_user.id
        redirect_to track_path(params[:track_id]), flash: { danger: 'You do not have permission to clear the interval' }
      end
    end

    def check_owner_track
      track = Track.find(params[:track_id])
      if track.user_id != current_user.id
        redirect_to track_path(params[:track_id]), flash: { danger: 'You do not have permission to create the interval' }
      end
    end
end
