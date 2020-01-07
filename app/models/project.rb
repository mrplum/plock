class Project < ApplicationRecord
    validates :name, :repository, :cost, presence: true
    validates :name, uniqueness: true
    validates :name, :repository, length: { minimum: 5 }
end
