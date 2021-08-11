class AnonymousUser
  include Permissionable

  def permissions
    User::DEFAULT_PERMISSIONS
  end

  def anonymous?
    true
  end
end
