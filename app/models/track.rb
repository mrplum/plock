# frozen_string_literal: true

# This class define the task model
require 'elasticsearch/model'

class Track < ApplicationRecord
  enum status: [ :unstarted, :in_progress, :finished ]

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

  def pause?
    status == in_progress? && intervals.all?(&:close)
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
      indexes :status, analyzer: 'english'
      indexes :plock_time, type: :integer
      indexes :user_id, type: :integer
      indexes :project_id, type: :integer
      indexes :created_at, type: :date
      indexes :updated_at, type: :date
    end
  end
end
