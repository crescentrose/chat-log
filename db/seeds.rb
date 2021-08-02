# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

%w[
  lax-1
  sfo-1
  sea-1
  chi-1
  dal-1
  nyc-1
  atl-1
  lon-1
  ber-1
  frk-1
  ham-1
].each do |name|
  Server.create(name: name, last_update: Time.now.utc)
end

berlin = Server.find_by(name: 'ber-1')

Message.create(
  message: 'Vayora is a very good pyro man',
  player_name: 'Uncle Dane',
  player_steamid3: '[U:1:97733808]',
  player_team: 'BLU',
  sent_at: 1.minute.ago,
  team: false,
  server: berlin
)

Message.create(
  message: 'thank you uncle dane, this is definitely a real message',
  player_name: 'VIORA',
  player_steamid3: '[U:1:94714121]',
  player_team: 'RED',
  sent_at: 30.seconds.ago,
  team: false,
  server: berlin
)
