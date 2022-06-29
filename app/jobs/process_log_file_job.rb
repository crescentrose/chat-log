class ProcessLogFileJob < ApplicationJob
  queue_as :default

  def perform(log_file)
    log_file.status_processing!

    processor = LogServerProcessingService.new
    server_name = log_file.server.name

    log_file.body.each_line do |line|
      processor.process(line, name: server_name)
    end

    log_file.status_processed!
  end
end
