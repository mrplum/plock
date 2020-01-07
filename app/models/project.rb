class Project < ApplicationRecord
    belongs_to :user
    has_many :teams
<<<<<<< HEAD

    validates :name, :repository, :cost ,presence: true
=======
    has_many :tasks

    validates :name, :repository, :cost, :user_id, presence: true
>>>>>>> change in bd
    validates :name, uniqueness: true
    validates :name, :repository, length: { minimum: 5 }
end
