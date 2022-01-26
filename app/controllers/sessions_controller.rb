class SessionsController < ApplicationController
  skip_before_action :verify_authenticity_token, only: :create

  def create
    self.current_user = User.find_or_create_from_auth_hash(omniauth_hash)
    self.current_user.update(
      last_login: Time.now,
      avatar_url: omniauth_hash['info']['image'],
      name: omniauth_hash['info']['nickname']
    )

    flash[:notice] = 'You have been logged in.'
    redirect_to '/'
  end

  def failure
    flash[:error] = "We could not log you in! Steam says: #{params[:message]}"
    redirect_to '/'
  end

  def destroy
    self.current_user = nil
    flash[:notice] = 'You have been logged out. Bye!'
    redirect_to '/'
  end

  private

  def omniauth_hash
    request.env['omniauth.auth']
  end
end
