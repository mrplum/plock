# frozen_string_literal: true

class User < ApplicationRecord
  include Devise::JWT::RevocationStrategies::JTIMatcher
  include Tokenizable

  has_many :team_users
  has_many :tracks
  has_many :teams, through: :team_users
  has_many :projects, through: :teams, source: :projects
  has_many :areas, through: :projects
  has_many :intervals
  belongs_to :company,  optional: true
  mount_uploader :avatar, AvatarUploader

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable,
         :registerable,
         :recoverable,
         :devise,
         :validatable,
         :trackable,
         :jwt_authenticatable,
         jwt_revocation_strategy: self

  def member_of?(project)
    (project.team_ids & team_ids).any?
  end

  def token
    JsonWebToken.encode(self)
  end
end
