class CategoryPolicy < ApplicationPolicy
  attr_reader :user, :record

  def initialize(user, record)
    @user = user
    @record = record
  end

  def index?
    user.admin? || user.owner?
  end

  def new?
    user.admin? || user.owner?
  end

  def show?
    user.admin? || user.owner?
  end

  def edit?
    user.admin? || user.owner?
  end

  def destroy?
    user.admin? || user.owner?
  end
end