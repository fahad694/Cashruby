class ItemPolicy < ApplicationPolicy
attr_reader :user, :record

  def initialize(user, record)
    @user = user
    @record = record
  end

  def new?
    user.admin? || user.owner?
  end

  def edit?
    user.admin? || user.owner?
  end

  def destroy?
    user.admin? || user.owner?
  end
end