# This model is for add Company into the system
class Company < ApplicationRecord
  has_many :project
  has_many :user

  validates :name, :description, presence: true
end
