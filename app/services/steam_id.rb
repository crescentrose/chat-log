class SteamId
  STEAM_ID_BASE = 76561197960265727.freeze

  def self.from(identifier)
    case identifier.to_s
    when /^STEAM_/
      from_id(identifier)
    when /^\[U:([0-1]:[0-9]+)\]$/
      from_id3(identifier)
    when /^7\d{16}$/
      new(identifier)
    else
      raise NotImplementedError, 'Vanity URLs are not supported in search yet.'
    end
  end

  # from Steam Condenser
  def self.from_id3(identifier)
    identifier =~ /^\[U:([0-1]:[0-9]+)\]$/
    steam_id3 = $1.split(':').map { |s| s.to_i }
    community_id = steam_id3[0] + steam_id3[1] + STEAM_ID_BASE
    new(community_id)
  end

  # https://developer.valvesoftware.com/wiki/SteamID
  def self.from_id(identifier)
    identifier =~ /STEAM_([0-1]:[0-9]:[0-9]+)$/
    universe, part, id = $1.split(':')
    new(id.to_i*2 + part.to_i + 1 + STEAM_ID_BASE) # add 1 because it's a profile ID magic number
  end

  attr_reader :id64

  def initialize(steamid64)
    @id64 = steamid64.to_i
  end

  def id
    "STEAM_#{universe}:#{id_part}:#{old_account_number}"
  end

  def id3
    "[U:1:#{account_number}]"
  end

  private

  def id_part
    id64 & 1
  end

  def account_number
    id64 & (2**32 - 1)
  end

  def universe
    id64 >> 2**8
  end

  def old_account_number
    account_number / 2
  end
end
