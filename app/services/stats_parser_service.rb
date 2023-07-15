class StatsParserService < ParserService
  DATETIME = %r{R?L (?<date>\d{2}/\d{2}/\d{4}) - (?<time>\d{2}:\d{2}:\d{2})}.freeze
  PLAYER = /"(?<player>.*)<\d+><(?<steamid>\[U:\d:\d+\])><(?<team>\w*)>"/.freeze
  VICTIM = /"(?<victim>.*)<\d+><(?<vsteamid>\[U:\d:\d+\])><(?<vteam>\w*)>"/.freeze

  KILLED_REGEX = /#{DATETIME}: #{PLAYER} killed #{VICTIM}/.freeze
  ASSIST_REGEX = /#{DATETIME}: #{PLAYER} triggered "kill assist" against #{VICTIM}/.freeze
  HEALED_REGEX = /#{DATETIME}: #{PLAYER} triggered "healed" against #{VICTIM} (healing "(?<amount>\d+)")/.freeze
  
  BONCA = "[U:1:177237803]".freeze

  attr_reader :redis

  def initialize(redis)
    @redis = redis
  end

  def can_parse?(line)
    true unless redis.nil?
  end

  def parse_line(line, server)
    case line
    when KILLED_REGEX
      redis.hincrby("bonca", "kills", 1) if $LAST_MATCH_INFO['steamid'] == BONCA
      redis.hincrby("bonca", "deaths", 1) if $LAST_MATCH_INFO['vsteamid'] == BONCA
    when ASSIST_REGEX
      redis.hincrby("bonca", "assists", 1) if $LAST_MATCH_INFO['steamid'] == BONCA
    when HEALED_REGEX
      redis.hincrby("bonca", "heals", $LAST_MATCH_INFO['amount'].to_i) if $LAST_MATCH_INFO['steamid'] == BONCA
    end

    nil
  end
end

