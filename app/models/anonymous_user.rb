class AnonymousUser
  include Permissionable

  def anonymous?
    true
  end

  def role
    Role.everyone
  end

  def steam_id3
    nil
  end
end
