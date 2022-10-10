class UserPolicy < ApplicationPolicy

  def new?
    user.role == 'owner'
  end

  def create_user?
    user.role == 'owner'
  end

  def index?
    user.role == 'owner' || user.role == 'admin'
  end
end
