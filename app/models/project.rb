# frozen_string_literal: true

require 'elasticsearch/model'
# Project class
#
class Project < ApplicationRecord
  include Indexable
  include Elasticsearch::Model
  include Elasticsearch::Model::Callbacks unless Rails.env.test?

  belongs_to :user, touch: true
  belongs_to :company, optional: true, touch: true
  belongs_to :team, optional: true, touch: true

  has_many :tracks, dependent: :destroy
  has_many :users, through: :team

  validates :name, :repository, :cost, :user_id, presence: true
  validates :name, uniqueness: true

  searchkick callbacks: false
  after_commit :index_elasticsearch

  def search_data
    {
      name: name,
      repository: repository,
      start_at: start_at,
      user_id: user_id,
      team_id: team_id,
      company_id: company_id,
      time_worked_project: time_worked_project
    }
  end

  settings index: { number_of_shards: 1 } do
    mapping dynamic: false do
      indexes :name, analyzer: 'english'
      indexes :repository, analyzer: 'english'
      indexes :start_at, type: :date
      indexes :user_id, type: :integer
      indexes :team_id, type: :integer
      indexes :company_id, type: :integer
    end
  end

  def as_indexed_json(_options = nil)
    as_json(
      only: %i[
        id name repository start_at
      ],
      include: {
        tracks: {
          only: %i[
            id name description plock_time
          ]
        },
        users: {
          only: %i[
            id name lastname email company_id
          ]
        }
      },
      methods: [
        :time_worked_project
      ]
    )
  end

  def time_worked_project
    Track.where(project_id: id).sum(&:plock_time)
  end
end
