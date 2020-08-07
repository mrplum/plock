# This model is for add Company into the system
class Company < ApplicationRecord
  has_many :projects
  has_many :users
  has_many :areas
  belongs_to :owner, class_name: "User"

  validates :name, :description, presence: true
end
