class Area < ApplicationRecord
  belongs_to :company
  has_many :projects

  validates :name, presence: true
end
