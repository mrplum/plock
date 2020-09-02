class CompanyPolicy < ApplicationPolicy
  def show?
    @user.admin? && record.owner == @user
  end

  def new?
    @user.admin? && record.owner == @user
  end

  def create?
    @user.admin? && record.owner == @user
  end

  def update?
    @user.admin? && record.owner == @user
  end

  def send_email?
    @user.admin? && record.owner == @user
  end

  def subscribe_user?
    @user.admin? && record.owner == @user
  end

  def remove_logo?
    @user.admin? && record.owner == @user
  end
end