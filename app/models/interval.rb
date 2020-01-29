# frozen_string_literal: true

require 'elasticsearch/model'

class Interval < ApplicationRecord
  include Indexable
  include Elasticsearch::Model
  include Elasticsearch::Model::Callbacks unless Rails.env.test?

  belongs_to :track, touch: true
  belongs_to :user
  validate :no_other_open_interval

  after_touch :calculate_plock_time
  after_commit :index_elasticsearch
  searchkick callbacks: false

  def open?
    created_at == updated_at
  end

  def no_other_open_interval
    if track.has_open_intervals?
      errors.add :base, 'There is already an open interval, please close before starting a new one'
    end
  end

  def search_data
    {
      created_at: created_at,
      updated_at: updated_at
    }
  end

  settings index: { number_of_shards: 1 } do
    mapping dynamic: false do
      indexes :created_at, type: :date
      indexes :updated_at, type: :date
    end
  end

  def as_indexed_json(_options = nil)
    as_json(
      only: %i[
        created_at updated_at
      ]
    )
  end

  private

  def calculate_plock_time
    minutes = (updated_at - created_at) / 1.minute
    track.plock_time = track.plock_time + minutes.to_i
    track.save
  end
end
