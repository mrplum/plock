class Team < ApplicationRecord
    has_many :teams_users
    validates :name, presence: true, length: { minimum: 3 }
end
