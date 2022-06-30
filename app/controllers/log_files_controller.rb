class LogFilesController < ApplicationController
  skip_before_action :verify_authenticity_token

  def create
    return head :forbidden unless authorized?

    server = Server.find_by(name: log_file_params[:server_name])

    return head :bad_request if server.nil?

    log_file = LogFile.new(
      server: server,
      map_name: params[:map_name],
      body: params[:body]
    )

    if log_file.save
      ProcessLogFileJob.perform_later(log_file)
      head :accepted
    else
      head :bad_request
    end
  end

  private

  def log_file_params
    params.permit(:server_name, :map_name, :body)
  end

  def authorized?
    request.headers["AUTHORIZATION"] == ENV.fetch('LOG_UPLOAD_PASSWORD')
  end
end
