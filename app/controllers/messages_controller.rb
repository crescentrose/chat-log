class MessagesController < ApplicationController
  helper_method :message, :should_stream_messages?, :allowed_stream_messages?

  def index
    authorize Message

    @q = policy_scope(Message)
      .includes(:server, :flag)
      .ransack(params.fetch(:q, {}).reverse_merge(default_query), auth_object: ransack_permission_level)
    
    @messages = @q
      .result
      .order(sent_at: :desc)
      .page(params[:page])
      .per(50)
      .without_count

  rescue NotImplementedError, SteamService::SteamError => e
    flash[:error] = e.message
    redirect_to messages_path
  end

  def show
    authorize message
    @previous = policy_scope(Message).includes(:server).where(sent_at: ...message.sent_at, server: message.server).order(sent_at: :desc).limit(20).reverse
    @next = policy_scope(Message).includes(:server).where(sent_at: message.sent_at..., server: message.server).order(sent_at: :asc).limit(21).drop(1)

    if request.headers["turbo-frame"]
      render partial: 'message', locals: { message: message, animate: true }
    else
      render 'show'
    end
  end

  private

  def message
    @message ||= policy_scope(Message).includes(:server).find(params[:id])
  end

  def should_stream_messages?
    allowed_stream_messages? && params[:page].nil? && params[:q].nil?
  end

  def allowed_stream_messages?
    policy(Message).full?
  end

  def ransack_permission_level
    return :admin if policy(Message).full?

    :user
  end

  def default_query
    {
      sent_at_gteq: 6.weeks.ago.to_date
    }
  end
end
