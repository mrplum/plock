# frozen_string_literal: true

# This class define the task model
require 'elasticsearch/model'

class Track < ApplicationRecord
  include Indexable
  include Elasticsearch::Model
  include Elasticsearch::Model::Callbacks unless Rails.env.test?

  validates :name, :description, presence: true

  has_many :intervals
  belongs_to :project, touch: true
  belongs_to :user, touch: true

  searchkick callbacks: false
  after_commit :index_elasticsearch

  def has_open_intervals?
    intervals.any?(&:open?)
  end

  def unstarted?
    status == 'Unstarted'
  end

  def ready?
    status == 'Finished'
  end

  def progress?
    status == 'In progress'
  end

  def pause?
    status == 'In Progress' && intervals.all?(&:close)
  end

  def open_interval
    intervals&.find(&:open?)
  end

  def search_data
    {
      name: name,
      description: description,
      status: status,
      plock_time: plock_time,
      user_id: user_id,
      project_id: project_id
    }
  end

  settings index: { number_of_shards: 1 } do
    mapping dynamic: false do
      indexes :name, analyzer: 'english'
      indexes :description, analyzer: 'english'
      indexes :status, type: :boolean
      indexes :plock_time, type: :integer
      indexes :user_id, type: :integer
      indexes :project_id, type: :integer
    end
  end

  def as_indexed_json(_options = nil)
    as_json(
      only: %i[
        id name description plock_time
      ],
      include: {
        intervals: {
          only: %i[
            id start_at end_at
          ]
        }
      }
    )
  end

end
