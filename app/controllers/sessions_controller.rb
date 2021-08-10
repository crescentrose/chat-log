class SessionsController < ApplicationController
  skip_before_action :verify_authenticity_token, only: :create

  def create
    self.current_user = User.find_or_create_from_auth_hash(omniauth_hash)
    redirect_to '/'
  end

  def destroy
    self.current_user = nil
    redirect_to '/'
  end

  private

  def omniauth_hash
    request.env['omniauth.auth']
  end
end
