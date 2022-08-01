require 'csv'

class ConnectionEventsController < ApplicationController
  def index
    authorize ConnectionEvent

    @q = ConnectionEvent
      .includes(:server)
      .ransack(params[:q])

    @connection_events = @q
      .result
      .order(connected_at: :desc)
      .page(params[:page])
      .per(100)
      .without_count

    respond_to do |format|
      format.csv do
        response.headers['Content-Type'] = 'text/csv'
        response.headers['Content-Disposition'] = 'attachment;filename=players.csv'
        render :index
      end
      format.html do
        render :index
      end
    end
  rescue NotImplementedError => e
    flash[:error] = e.message
    redirect_to votekick_events_path
  end
end
