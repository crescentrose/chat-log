class LogFilesController < ApplicationController
  before_action :authenticate
  skip_before_action :verify_authenticity_token

  def create
    @log_file = LogFile.new(log_file_params)

    if @log_file.save
      ParseLogFileJob.perform_later(@log_file)
      head :created
    else
      head :bad_request
    end
  end

  private

  def log_file_params
    params
      .require(:log_file)
      .permit(:file)
      .merge(
        server: Server.from_name(params[:log_file][:server_name]),
        processed: false
      )
  end

  def authenticate
    return unless ENV['LOG_UPLOAD_PASSWORD'].present?

    authenticate_or_request_with_http_token do |token, options|
      ActiveSupport::SecurityUtils.secure_compare(token, ENV['LOG_UPLOAD_PASSWORD'])
    end
  end
end
