class ConnectionParserService < ParserService
  ParsedConnectionEvent = Struct.new(
    :connected_at, :ip, :player_name, :player_steamid3, :server_id,
    keyword_init: true
  ) do
    def to_model
      ConnectionEvent.new(to_h)
    end
  end

  CONNECTED_REGEX = %r{R?L (?<date>\d{2}/\d{2}/\d{4}) - (?<time>\d{2}:\d{2}:\d{2}): "(?<player>.*)<\d+><(?<steamid>\[U:\d:\d+\])><(?<team>\w*)>" connected,\s*address "(?<ip>\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3}):\d*"}.freeze

  def initialize(trusted_users = [])
    @trusted_users = trusted_users
  end

  def can_parse?(line)
    line =~ /connected/
  end

  def parse_line(line, server)
    return unless match = line.strip.match(CONNECTED_REGEX)

    ParsedConnectionEvent.new(
      connected_at: match_to_datetime(match, server.timezone),
      player_name: match[:player],
      player_steamid3: match[:steamid],
      ip: match_to_ip(match),
      server_id: server.id
    )
  end

  private

  attr_reader :trusted_users

  def match_to_ip(match)
    return '0.0.0.0' if trusted_users.include? match[:steamid]

    match[:ip]
  end
end
