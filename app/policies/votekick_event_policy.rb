class VotekickEventPolicy < ApplicationPolicy
  def index?
    user.allowed_to?('votekicks.index')
  end
end
