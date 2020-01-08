# frozen_string_literal: true

# Project class
#
class Project < ApplicationRecord
  belongs_to :user
  has_one :team
  has_many :tasks
  has_many :users, through: :team

  validates :name, :repository, :cost, :user_id, presence: true
  validates :name, uniqueness: true
  validates :name, :repository, length: { minimum: 5 }
end
