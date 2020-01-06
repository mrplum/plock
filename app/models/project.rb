class Project < ApplicationRecord
    validates :name, :repository, :cost ,presence: true
    validates :name, uniqueness: true
    validates :name, :repository, length: { minimum: 5 }
    validates :cost, length: { minimum: 1 }
end
