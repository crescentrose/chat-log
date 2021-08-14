class ServerPolicy < ApplicationPolicy
  def index?
    user.allowed_to?('servers.index')
  end

  def show?
    index?
  end

  def admin?
    update?
  end

  def edit?
    update?
  end

  def update?
    user.allowed_to?('servers.update')
  end

  def new?
    update?
  end

  def create?
    update?
  end

  def destroy?
    update?
  end
end

