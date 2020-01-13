class User < ApplicationRecord
  has_many :team_users
  has_many :tracks
  has_many :teams, through: :team_users
  has_many :projects #, through: :teams, source: :projects
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  def as_csv(options = {})
    csv = {
      name: name,
      lastname: lastname,
      email: email,
      created_at: created_at,
      updated_at: updated_at,
      }
  end

end
