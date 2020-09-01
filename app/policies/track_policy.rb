class TrackPolicy < ApplicationPolicy

  def show?
    @user.admin? || @user.member_of?(record.project)
  end

  def new?
    @user.admin? || @user.member_of?(record.project)
  end

  def edit?
    @user.admin? || @user.id == record.user_id
  end

  def create?
    @user.admin? || @user.id == record.user_id
  end

  def update?
    @user.admin? || @user.id == record.user_id
  end

  def destroy?
    @user.admin? || @user.id == record.user_id
  end
end