class MessagesController < ApplicationController
  def index
    @messages = Message.includes(:server).all.order(:sent_at)
  end

  def upload
  end
end
