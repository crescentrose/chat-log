class ServerStatusUpdateService
  MAP_REGEX = /^map\s+: (?<map>\w+)/
  PLAYERS_REGEX = /^players\s+: (?<players>\d+)/
  Status = Struct.new(:map, :players, keyword_init: true)

  def update(server)
    status = parse_status(
      server.rcon_client
            .execute('status')
            .body
            .force_encoding('utf-8')
    )

    server.rcon_client.end_session!

    server.update!(
      map: status.map,
      players: status.players,
      last_update: Time.now.utc
    )

    server
  end

  private

  def parse_status(status)
    map = status.match(MAP_REGEX)[:map]
    players = status.match(PLAYERS_REGEX)[:players]

    Status.new(map: map, players: players.to_i)
  end
end
