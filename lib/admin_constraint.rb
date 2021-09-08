class AdminConstraint
  def matches?(request)
    return false unless request.session[:user_id]
    user = User.includes(role: :permissions).find(request.session[:user_id])
    user && user.root?
  end
end
