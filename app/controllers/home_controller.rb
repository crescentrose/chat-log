class HomeController < ApplicationController
  def index
    redirect_to messages_path
  end
end
