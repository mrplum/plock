# frozen_string_literal: true

# Project class
#
class Project < ApplicationRecord
  belongs_to :user, touch: true
  belongs_to :area, optional: true
  belongs_to :company, optional: true, touch: true
  belongs_to :team, optional: true, touch: true
  has_many :tracks, dependent: :destroy
  has_many :users, through: :team

  validates :name, :description, :cost, :user_id, presence: true
  validates :name, uniqueness: true

  def time_worked_project
    Track.where(project_id: id).sum(&:plock_time)
  end
end
