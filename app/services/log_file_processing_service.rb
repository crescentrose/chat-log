class LogFileProcessingService
  def initialize(logger=nil)
    @logger = logger || Rails.logger
    @parsers = [
      MessageParserService.new,
      VotekickParserService.new,
      ConnectionParserService.new(trusted_users),
      DisconnectionParserService.new
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
      # TODO: log errors here
      events.each { |event| event.save!(validate: false) }
      log_file.update(processed: true)
    end

    events
  end

  private

  attr_reader :logger

  def sanitize(string)
    string.encode('utf-8', invalid: :replace, undef: :replace)
  end

  def trusted_users
    User.with_permission('connections.obscure').pluck(:steam_id3)
  end
end
