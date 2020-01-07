class Task < ApplicationRecord
  validates :name, :description, presence: true
end
