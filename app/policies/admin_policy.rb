class AdminPolicy < ApplicationPolicy
  def sidebar?
    user.admin?
  end

  def is_admin?
    user.admin?
  end
end
