class LogFileProcessingService
  def process(log_file)
    return if log_file.processed?

    messages = parser
      .parse(log_file.contents, log_file.server.timezone)
      .map { |message| message.to_h.merge(server_id: log_file.server_id, created_at: Time.now, updated_at: Time.now) }
      .compact

    Message.insert_all(messages) unless messages.empty?
  ensure
    log_file.update(processed: true)
  end

  private

  def parser = @parser ||= MessageParserService.new
end
