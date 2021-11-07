class DisconnectionParserService < ParserService
  ParsedDisconnectionEvent = Struct.new(
    :disconnected_at, :reason, :player_name, :player_steamid3, :server_id,
    keyword_init: true
  ) do
    def to_model
      DisconnectionEvent.new(to_h)
    end
  end

  DISCONNECTED_REGEX = %r{R?L (?<date>\d{2}/\d{2}/\d{4}) - (?<time>\d{2}:\d{2}:\d{2}): "(?<player>.*)<\d+><(?<steamid>\[U:\d:\d+\])><(?<team>\w*)>" disconnected\s*\(reason "(?<reason>[^"\)]*)}.freeze

  def can_parse?(line)
    line =~ /disconnected/
  end

  def parse_line(line, server)
    return unless (match = line.strip.match(DISCONNECTED_REGEX))

    ParsedDisconnectionEvent.new(
      disconnected_at: match_to_datetime(match, server.timezone),
      player_name: match[:player],
      player_steamid3: match[:steamid],
      reason: match[:reason],
      server_id: server.id
    )
  end
end
