# frozen_string_literal: true

# This class define the task model

class Track < ApplicationRecord
  enum status: [ :unstarted, :in_progress, :finished ]

  validates :name, :description, presence: true

  has_many :intervals
  belongs_to :project, touch: true
  belongs_to :user, touch: true
  belongs_to :team, touch: true

  def has_open_intervals?
    intervals.any?(&:open?)
  end

  def pause?
    status == in_progress? && intervals.all?(&:close)
  end

  def open_interval
    intervals&.find(&:open?)
  end
end
