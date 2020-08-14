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

    @interval = Interval.new(
      interval_params.merge({
        user_id: current_user.id,
        track_id: params[:track_id],
        start_at: start_at,
        end_at: end_at
      })
    )

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

    def check_owner_interval
      interval = Interval.find(params[:id])
      if interval.user_id != current_user.id
        if params[:modal].present? && params[:modal] != 'complete'
          project = Track.find_by(id: params[:track_id]).project
          redirect_to project_path(project), flash: { danger: t('error_permission') }
        else
          redirect_to track_path(params[:track_id]), flash: { danger: t('error_permission') }
        end
      end
    end

    def check_owner_track
      track = Track.find(params[:track_id])
      if track.user_id != current_user.id
        if modal_params.present? && modal_params[:modal] != 'complete'
          project = Track.find_by(id: params[:track_id]).project
          redirect_to project_path(project), flash: { danger: t('error_permission') }
        else
          redirect_to track_path(params[:track_id]), flash: { danger: t('error_permission') }
        end
      end
    end

    def automatic_interval_creation?
      params[:interval][:start_track] == 'true'
    end
end
