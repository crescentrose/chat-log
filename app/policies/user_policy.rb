class UserPolicy < ApplicationPolicy
  def index?
    user.allowed_to?('users.index')
  end

  def update?
    user.root?
  end

  def create?
    update?
  end
end
