class ServerGroupPolicy < ApplicationPolicy
  def index?
    user.allowed_to?('servers.index')
  end

  def update?
    user.allowed_to?('servers.update')
  end

  def create?
    update?
  end

  def destroy?
    update?
  end
end
