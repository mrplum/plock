class User < ApplicationRecord
  has_many :team_users
  has_many :tasks
  has_many :teams, through: :team_users
  has_many :projects, through: :teams #source: :projects
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
end
