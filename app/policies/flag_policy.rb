class FlagPolicy < ApplicationPolicy
  def index?
    user.root?
  end

  def create?
    user.root?
  end

  def update?
    user.root?
  end

  def destroy?
    user.root?
  end

  def new?
    user.root?
  end

  def edit?
    user.root?
  end

  def resolve?
    user.allowed_to?('flag.resolve')
  end
end
