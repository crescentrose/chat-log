class ParseLogFileJob < ApplicationJob
  queue_as :default

  def perform(log_file)
    return if log_file.processed?

    server_id = log_file.server_id
    messages = parser
      .parse_blob(log_file.file)
      .map { |message| message.to_h.merge(server_id: server_id, created_at: Time.now, updated_at: Time.now) }
      .compact

    Message.insert_all(messages) unless messages.empty?
  ensure
    log_file.update(processed: true)
  end

  private

  def parser = @parser ||= LogParserService.new
end
