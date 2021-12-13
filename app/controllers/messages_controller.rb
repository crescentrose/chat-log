class MessagesController < ApplicationController
  helper_method :message

  def index
    authorize Message

    @q = Message
      .uncommon
      .includes(:server)
      .ransack(params[:q])

    @messages = @q
      .result
      .order(sent_at: :desc)
      .page(params[:page])
      .per(50)
      .without_count
  rescue NotImplementedError => e
    flash[:error] = e.message
    redirect_to messages_path
  end

  def show
    authorize message
    @previous = Message.includes(:server).where(sent_at: ...message.sent_at, server: message.server).order(sent_at: :desc).limit(20).reverse
    @next = Message.includes(:server).where(sent_at: message.sent_at..., server: message.server).order(sent_at: :asc).limit(21).drop(1)
  end

  private

  def message
    @message ||= Message.includes(:server).find(params[:id])
  end
end
