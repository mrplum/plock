# frozen_string_literal: true

# Team class
#
class Team < ApplicationRecord
  has_many :team_users
  has_many :users, through: :team_users, source: :user
  has_many :project_teams
  has_many :projects, through: :project_teams

  validates :name, presence: true, length: { minimum: 3 }

  def time_worked_team
    Project.where(team_id: id).sum(&:time_worked_project)
  end
end
