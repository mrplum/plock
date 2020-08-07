# frozen_string_literal: true

# Project class
#
class Project < ApplicationRecord
  belongs_to :user, touch: true
  belongs_to :area, optional: true
  belongs_to :company, optional: true, touch: true
  belongs_to :team, optional: true # Main Team

  has_many :project_teams
  has_many :teams, through: :project_teams
  has_many :tracks, dependent: :destroy
  has_many :users, through: :teams

  validates :name, :description, :user_id, presence: true
  validates :name, uniqueness: true

  after_create :create_owners_team

  def time_worked_project
    Track.where(project_id: id).sum(&:plock_time)
  end

  private
  def create_owners_team
    t = Team.create(name: "Owners Team #{name}", project_id: id)
    t.users << user
    self.teams << t
  end
end
