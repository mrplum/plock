# frozen_string_literal: true

# Project class
#
class Project < ApplicationRecord
  belongs_to :user, touch: true
  belongs_to :area, optional: true
  belongs_to :company, optional: true, touch: true
  belongs_to :team # Main Team

  has_many :project_teams
  has_many :teams, through: :project_teams
  has_many :tracks, dependent: :destroy
  has_many :users, through: :team

  validates :name, :description, :cost, :user_id, presence: true
  validates :name, uniqueness: true
end
