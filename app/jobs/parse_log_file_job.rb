class ParseLogFileJob < ApplicationJob
  queue_as :default

  def perform(log_file)
    LogFileProcessingService.new.process(log_file)
  end
end
