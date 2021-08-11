class MessagesController < ApplicationController
  helper_method :message

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

  def show
    authorize message
    @previous = Message.includes(:server).where(id: ...message.id, server: message.server).order(sent_at: :desc).limit(10).reverse
    @next = Message.includes(:server).where(id: (message.id+1).., server: message.server).order(sent_at: :asc).limit(10)
  end

  private

  def message
    @message ||= Message.includes(:server).find(params[:id])
  end
end
