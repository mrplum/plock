# frozen_string_literal: true

# class IntervalsController
#
class IntervalsController < ApplicationController
  before_action :authenticate_user!
  before_action :get_track, only: [:new, :create, :update]
  before_action :get_interval, only: [:update, :destroy]

  def new
    @interval = @track.intervals.build(user_id: current_user.id)
    authorize @track
  end

  def create

    start_at = params[:start_at] || DateTime.now
    end_at = params[:end_at] || start_at

    @interval = Interval.new(
      interval_params.merge({
        user_id: current_user.id,
        track_id: @track.id,
        start_at: start_at,
        end_at: end_at
      })
    )
    authorize @track
    respond_to do |format|
      if @interval.save
        if modal_params.present? && modal_params[:modal] != 'complete'
          format.html { redirect_to project_path(@interval.track.project) }
          format.json { redirect_to project_path(@interval.track.project), status: :created, location: @interval }
        else
          format.html { redirect_to track_path(@interval.track) }
          format.json { redirect_to track_path(@interval.track), status: :created, location: @interval }
        end
      else
        flash[:danger] = @interval.errors.full_messages
        if modal_params.present?
          if modal_params[:modal] == 'complete'
            format.html { redirect_to track_path(@interval.track) }
          else
            format.html { redirect_to project_path(@interval.track.project) }
          end
        else
          format.html do
            get_track
            if automatic_interval_creation?
              redirect_to track_path(@interval.track)
            else
              render :new
            end
          end
        end
        format.json { render json: @interval.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    authorize @interval
    respond_to do |format|
      if @interval.update(interval_params.merge({end_at: DateTime.now}))
        if modal_params.present? && modal_params[:modal] != 'complete'
          format.html { redirect_to project_path(@interval.track.project) }
          format.json { redirect_to project_path(@interval.track.project), status: :ok, location: @interval }
        else
          format.html { redirect_to track_path(@interval.track) }
          format.json { redirect_to track_path(@interval.track), status: :ok, location: @interval }
        end
      else
        flash[:danger] = @interval.errors.full_messages
        if modal_params.present? && modal_params[:modal] != 'complete'
          format.html { redirect_to project_path(@interval.track.project) }
          format.json { render json: @interval.errors, status: :unprocessable_entity }
        else
          format.html { redirect_to track_path(@interval.track) }
          format.json { render json: @interval.errors, status: :unprocessable_entity }
        end
      end
    end
  end

  def destroy
    authorize @interval
    @interval.destroy
    respond_to do |format|
      flash[:success] = t('.success')
      format.html { redirect_to track_url(@interval.track) }
      format.json { head :no_content }
    end
  end

  private

    def interval_params
      params.require(:interval)
        .permit(:track_id, :user_id, :start_at, :end_at, :description, :close_track, :start_track)
    end

    def modal_params
      params.require(:interval).permit(:modal)
    end

    def get_track
      @track = Track.find(params[:track_id])
    end

    def get_interval
      @interval = @track&.open_interval || Interval.find(params[:id])
    end

    def automatic_interval_creation?
      params[:interval][:start_track] == 'true'
    end
end
