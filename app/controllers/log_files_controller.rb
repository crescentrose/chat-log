class LogFilesController < ApplicationController
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
end
