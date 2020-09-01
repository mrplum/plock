class ProjectPolicy < ApplicationPolicy

  def show?
    @user.admin? || @user.member_of?(record)
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