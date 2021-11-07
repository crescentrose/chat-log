class MessageParserService < ParserService
  ParsedMessage = Struct.new(
    :message, :player_name, :player_steamid3, :player_team, :sent_at, :team,
    :server_id, :flagged_at, keyword_init: true
  ) do
    def to_model
      Message.new(to_h)
    end
  end

  MESSAGE_REGEX = %r{
    R?L\                             # Each log line starts with RL or L
                                     # followed by a space.
    (?<date>\d{2}/\d{2}/\d{4})\      # This will match the date (mm-dd-yyyy)
    -\ (?<time>\d{2}:\d{2}:\d{2}):\  # Then we match the time (hh:mm:ss).
    "(?<player>.*)<\d+>              # Match player name and skip over their
                                     # ingame ID (we do not need it yet)
    <(?<steamid>\[U:\d:\d+\])>       # Get their SteamID3 ([U:1:12345678])
    <(?<team>Blue|Red)>"\            # Match their team to either Blu or Red
    say(?<tc>_team)?\                # Team chat messages are a bit different.
    "(?<message>.*)"                 # Match their actual message
  }x.freeze

  def initialize
    @filter = Swearjar.new(Rails.root + 'config/swears.yml')
  end

  def can_parse?(line)
    line =~ / say "/ || line =~ / say_team "/
  end

  def parse_line(line, server)
    return unless matches = line.strip.match(MESSAGE_REGEX)

    ParsedMessage.new(
      message: matches[:message],
      player_name: matches[:player],
      player_steamid3: matches[:steamid],
      player_team: player_team(matches[:team]),
      sent_at: match_to_datetime(matches, server.timezone),
      team: !matches[:tc].nil?,
      server_id: server.id,
      flagged_at: filter.profane?(matches[:message]) ? Time.now.utc : nil
    )
  end

  private

  attr_reader :filter
end
