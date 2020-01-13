# This model is for add Company into the system
class Company < ApplicationRecord
  has_many :projects
  has_many :users
  belongs_to :user

  validates :name, :description, presence: true
end
