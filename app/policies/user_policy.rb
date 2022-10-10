class UserPolicy < ApplicationPolicy

  def new?
    user.owner?
  end

  def create_user?
    user.owner?
  end

  def index?
    user.owner? || user.admin?
  end
end
