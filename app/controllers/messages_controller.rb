class MessagesController < ApplicationController
  def index
    @messages = Message
      .includes(:server)
      .order(:sent_at)
      .page(params[:page])
  end
end
