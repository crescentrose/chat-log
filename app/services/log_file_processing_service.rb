class LogFileProcessingService
  def initialize
    @parsers = [
      MessageParserService.new,
      VotekickParserService.new
    ]
  end

  def process(log_file)
    return if log_file.processed?

    server = log_file.server

    events =
      log_file
        .contents
        .then { |log| sanitize(log) }
        .lines
        .flat_map do |line|
          @parsers.flat_map { |parser| parser.parse_line(line, server) }
        end
        .compact
        .map(&:to_model)

    ActiveRecord::Base.transaction do
      events.each(&:save!)
      log_file.update(processed: true)
    end

    events
  end

  private

  def sanitize(string)
    string.encode('utf-8', invalid: :replace, undef: :replace)
  end
end
