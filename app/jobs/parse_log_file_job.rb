class ParseLogFileJob < ApplicationJob
  queue_as :default

  def perform(log_file)
    LogFileProcessingService.new(Sidekiq.logger).process(log_file)
  end
end
