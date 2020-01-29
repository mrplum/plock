# frozen_string_literal: true

require 'elasticsearch/model'
# Team class
#
class Team < ApplicationRecord
  include Indexable
  include Elasticsearch::Model
  include Elasticsearch::Model::Callbacks unless Rails.env.test?

  has_many :team_users
  has_many :users, through: :team_users, source: :user
  has_many :projects

  validates :name, presence: true, length: { minimum: 3 }

  searchkick callbacks: false
  after_commit :index_elasticsearch

  def search_data
    {
      name: name
    }
  end

  settings index: { number_of_shards: 1 } do
    mapping dynamic: false do
      indexes :name, analyzer: 'english'
    end
  end

  def as_indexed_json(_options = nil)
    as_json(
      only: %i[
        id name
      ],
      include: {
        projects: {
          only: %i[
            id name repository start_at
          ],
          methods: [
            :time_worked_project
          ]
        },
        users: {
          only: %i[
            id name lastname email company_id
          ]
        }
      },
      methods: [
        :time_worked_team
      ]
    )
  end

  def time_worked_team
    Project.where(team_id: id).sum(&:time_worked_project)
  end
end
