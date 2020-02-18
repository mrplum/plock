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
      indexes :start_at, type: :date
      indexes :end_at, type: :date
    end
  end

  def as_indexed_json(_options = nil)
    as_json(
      only: %i[
        start_at end_at
      ]
    )
  end

  private

  def calculate_plock_time
    minutes = (end_at - start_at) / 1.minute
    track.plock_time = track.plock_time + minutes.to_i
    track.save
  end

  def change_track_status
    if start_track
      track.status = :in_progress
    elsif close_track
      track.status = :finished
    end
    track.save
  end

end
