class MessagesController < ApplicationController
  def index
    authorize Message

    @q = Message
      .includes(:server)
      .ransack(params[:q])

    @messages = @q
      .result(distinct: true)
      .order(sent_at: :desc)
      .page(params[:page])
      .per(50)
      .without_count
  rescue NotImplementedError => e
    flash[:error] = e.message
    redirect_to messages_path
  end
end
