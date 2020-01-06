class Project < ApplicationRecord
    validates :name, :repository, :cost, :start_at ,presence: true
    validates :name, :repository, uniqueness: true
    validates :name, :repository, length: { minimum: 5 }
    validates :cost, length: { minimum: 1 }
end
