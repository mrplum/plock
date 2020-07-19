# frozen_string_literal: true

require 'elasticsearch/model'

class Interval < ApplicationRecord
  include Indexable
  include Elasticsearch::Model
  include Elasticsearch::Model::Callbacks unless Rails.env.test?

  attr_accessor :close_track, :start_track

  belongs_to :track, touch: true
  belongs_to :user

  validates :description, presence: true
  validate :no_other_open_interval, on: %i[create]
  validate :valid_date

  after_create :update_minutes
  after_update :update_minutes
  after_destroy :reset_track_status
  after_commit :calculate_plock_time, :index_elasticsearch
  before_save :change_track_status, if: -> { close_track || start_track }

  searchkick callbacks: false

  def open?
    start_at == end_at
  end

  def close?
    !open?
  end

  def valid_start_date?
    track.project.start_at <= start_at
  end

  def valid_interval_dates?
    self.start_at <= self.end_at
  end

  def same_day?
    start_at.to_date == end_at.to_date
  end

  def no_other_open_interval
    if track.has_open_intervals?
      self.errors.add :base, 'There is already an open interval, please close before starting a new one'
    end
  end

  def valid_date
    if !valid_start_date? || !valid_interval_dates?
      self.errors.add :base, 'invalid Dates!'
    end
  end

  def search_data
    {
      start_at: start_at,
      end_at: end_at
    }
  end

  settings index: { number_of_shards: 1 } do
    mapping dynamic: false do
      indexes :user_id, type: :integer
      indexes :track_id, type: :integer
      indexes :start_at, type: :date
      indexes :end_at, type: :date
      indexes :minutes, type: :integer
    end
  end

  def as_indexed_json(_options = nil)
    as_json(
      only: %i[
        id track_id user_id start_at end_at minutes
      ]
    )
  end

  private

  def calculate_minutes
    (end_at - start_at) / 1.minute
  end

  def calculate_plock_time
    minutes = calculate_minutes
    track.plock_time = self.destroyed? ? track.plock_time - minutes.to_i : track.plock_time + minutes.to_i
    track.save
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
    if track.intervals.empty? && (track.in_progress? || track.finished?)
      track.status = :unstarted
      track.save
    end
  end

end
