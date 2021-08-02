class MessagesController < ApplicationController
  def index
    @q = Message
      .includes(:server)
      .ransack(params[:q])

    @messages = @q
      .result(distinct: true)
      .order(:sent_at)
      .page(params[:page])
  end
end
