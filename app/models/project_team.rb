# frozen_string_literal: true

# ProjectTeam class
#
class ProjectTeam < ApplicationRecord
  belongs_to :project
  belongs_to :team
end
