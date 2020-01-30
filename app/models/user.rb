# frozen_string_literal: true

require 'elasticsearch/model'

class User < ApplicationRecord
  include Indexable
  include Elasticsearch::Model
  include Elasticsearch::Model::Callbacks unless Rails.env.test?
  include Devise::JWT::RevocationStrategies::JTIMatcher
  include Tokenizable

  has_many :team_users
  has_many :tracks
  has_many :teams, through: :team_users
  has_many :projects, through: :teams, source: :projects
  has_many :intervals
  belongs_to :company

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable,
         :registerable,
         :recoverable,
         :devise,
         :validatable,
         :trackable,
         :jwt_authenticatable,
         jwt_revocation_strategy: self

  searchkick callbacks: false
  after_commit :index_elasticsearch

  def search_data
    {
      name: name,
      lastname: lastname,
      email: email,
      company_id: company_id,
      time_worked_user: time_worked_user
    }
  end

  settings index: { number_of_shards: 1 } do
    mapping dynamic: false do
      indexes :name, analyzer: 'english'
      indexes :lastname, analyzer: 'english'
      indexes :email, analyzer: 'english'
      indexes :company_id, type: :integer
    end
  end

  def as_indexed_json(_options = nil)
    as_json(
      only: %i[
        id name lastname email company_id
      ],
      include: {
        tracks: {
          only: %i[
            id name description plock_time
          ]
        },
        teams: {
          only: %i[
            id name
          ]
        },
        projects: {
          only: %i[
            id name repository start_at
          ],
          methods: [
            :time_worked_project
          ]
        }
      }
    )
  end

  def member_of?(project)
    project.team.in?(teams)
  end
end
