# frozen_string_literal: true

# TeamUser class
#
class TeamUser < ApplicationRecord
  belongs_to :team
  belongs_to :user

  validates :user_id, presence: true
  # validates :team_id, presence: true
end
