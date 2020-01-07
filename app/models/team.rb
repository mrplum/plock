class Team < ApplicationRecord
    belongs_to :project
    validates :name, presence: true,
                      length: { minimum: 3 }

    validates :project_id, presence: true
end
