class CompanyPolicy < ApplicationPolicy
  def show?
    @user.admin?
  end

  def new?
    @user.admin?
  end

  def create?
    @user.admin?
  end

  def update?
    @user.admin?
  end

  def send_email?
    @user.admin?
  end

  def subscribe_user?
    @user.admin?
  end

  def remove_logo?
    @user.admin?
  end
end