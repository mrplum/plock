# This class define the task model
class Track < ApplicationRecord
  validates :name, :description, presence: true
  has_many :intervals
  belongs_to :project, dependent: :destroy
  belongs_to :user, dependent: :destroy
end
