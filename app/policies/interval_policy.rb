class IntervalPolicy < ApplicationPolicy

  def new?
    @user.admin? || record.user_id == @user.id
  end

  def create?
    @user.admin? || record.user_id == @user.id
  end

  def edit?
    @user.admin? || record.user_id == @user.id
  end

  def update?
    @user.admin? || record.user_id == @user.id
  end

  def destroy?
    @user.admin? || record.user_id == @user.id
  end
end
