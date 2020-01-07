class Project < ApplicationRecord
    belongs_to :users
    has_many :tasks
    has_many :teams

    validates :name, :repository, :cost ,presence: true
    validates :name, uniqueness: true
    validates :name, :repository, length: { minimum: 5 }
end
