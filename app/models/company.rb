# This model is for add Company into the system
class Company < ApplicationRecord
  validates :name, :description, presence: true
end
