class MessagePolicy < ApplicationPolicy
  def index?
    user.allowed_to?('messages.index')
  end

  def show?
    index?
  end

  def full?
    user.allowed_to?('message.full_index')
  end

  class Scope < Scope
    def resolve
      return scope.all if user.allowed_to?('message.full_index')

      scope.recent
    end
  end
end
