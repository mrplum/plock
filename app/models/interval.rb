# frozen_string_literal: true

require 'elasticsearch/model'

class Interval < ApplicationRecord
  include Indexable
  include Elasticsearch::Model

  attr_accessor :close_track, :start_track

  belongs_to :track, touch: true
  belongs_to :user

  validate :no_other_open_interval, on: %i[create]
  validate :valid_date

  after_commit :change_track_status, if: -> { close_track || start_track }
  after_commit :calculate_plock_time, :reset_track_status
  after_commit :update_minutes, on: [:create, :update]

  # reindex elasticsearch
  after_commit -> { index_elasticsearch('create') }, on: [:create]
  after_commit -> { index_elasticsearch('update') }, on: [:update]
  before_destroy -> { index_elasticsearch('destroy') }

  def as_indexed_json(_options = nil)
    track = self.track
    project = track.project
    {
      id: id,
      description: description,
      company_id: project.company_id,
      user_id: user_id,
      track_id: track_id,
      project_id: track.project_id,
      team_id: project.team_id,
      area_id: project.area_id,
      start_at: start_at,
      end_at: end_at,
      minutes: minutes
    }
  end

  def open?
    start_at == end_at
  end

  def close?
    !open?
  end

  def valid_interval_dates?
    self.start_at <= self.end_at
  end

  def same_day?
    start_at.to_date == end_at.to_date
  end

  def no_other_open_interval
    if track&.has_open_intervals?
      self.errors.add :base, 'There is already an open interval, please close before starting a new one'
    end
  end

  def valid_date
    if !valid_interval_dates?
      self.errors.add :base, 'invalid Dates!'
    end
  end

  private

  def calculate_minutes
    (end_at - start_at) / 1.minute
  end

  def calculate_plock_time
    minutes = calculate_minutes
    if !track.destroyed?
      track.plock_time = self.destroyed? ? track.plock_time - minutes.to_i : track.plock_time + minutes.to_i
      track.save
    end
  end

  def update_minutes
    minutes = calculate_minutes
    self.update_columns(minutes: minutes.to_i)
  end

  def change_track_status
    if start_track
      track.status = :in_progress
    elsif close_track
      track.status = :finished
    end
    track.save
  end

  def reset_track_status
    if !track.destroyed? && track.intervals.empty? && (track.in_progress? || track.finished?)
      track.status = :unstarted
      track.save
    end
  end

end
