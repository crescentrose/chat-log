class SteamService
  BASE_URL = 'https://api.steampowered.com'.freeze
  PlayerSummary = Struct.new(:steam_id, :name, :avatar_url, keyword_init: true)

  def initialize(api_key=nil)
    @api_key = api_key || ENV['STEAM_WEB_API_KEY']
  end

  def resolve_vanity_url(vanity_url)
    id = get('ISteamUser', 'ResolveVanityURL', vanityurl: vanity_url)
      .dig('response', 'steamid')

    SteamId.from(id)
  end

  def player_summary(steamids)
    steamids = Array.wrap(steamids)
                    .map { |id| SteamId.from(id) }
                    .map(&:id64)
                    .join(',')
    details = get('ISteamUser', 'GetPlayerSummaries', steamids: steamids, version: 'v2')
      .dig('response', 'players')
      .map do |player|
        PlayerSummary.new(
          steam_id: SteamId.from(player.dig('steamid')),
          name: player.dig('personaname'),
          avatar_url: player.dig('avatarmedium')
        )
      end

    return details.first if details.size == 1
    details
  end

  class SteamError < StandardError; end

  private

  def get(interface, method, params={})
    params = params.merge(key: @api_key)
    url = [BASE_URL, interface, method, params.fetch(:version, 'v1')].join('/')

    response = Faraday.get(url, params.except(:version))

    raise SteamError, "steam api request failure (#{url} returned #{response.status})" unless response.success?

    json = JSON.parse(response.body)
    raise SteamError, "steam can't find this profile (don't use the full URL, I am too lazy to implement that)" unless json.dig('response', 'message') != 'No match'

    json
  end
end
