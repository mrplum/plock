class Task < ApplicationRecord
  #validates :name, :description, presence: true
  belongs_to :project, dependent: :destroy
  belongs_to :user, dependent: :destroy
end
