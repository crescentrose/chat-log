class SSHKeyPolicy < ApplicationPolicy
  def index?
    user.root?
  end

  def new?
    user.root?
  end

  def create?
    user.root?
  end

  def destroy?
    user.root?
  end
end
