class TeamPolicy < ApplicationPolicy

  def show?
    @user.admin? || record.users.find_by(id: @user.id).present?
  end

  def edit?
    @user.admin? || record.users.find_by(id: @user.id).present?
  end

  def update?
    @user.admin? || record.users.find_by(id: @user.id).present?
  end

  def destroy?
    @user.admin? || record.users.find_by(id: @user.id).present?
  end
end