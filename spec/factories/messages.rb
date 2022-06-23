# == Schema Information
#
# Table name: messages
#
#  id              :bigint           not null, primary key
#  message         :text             not null
#  player_name     :string           not null
#  player_steamid3 :string           not null
#  player_team     :string           not null
#  sent_at         :datetime         not null
#  team            :boolean          default(FALSE), not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  server_id       :bigint           not null
#
# Indexes
#
#  index_messages_on_player_name      (player_name)
#  index_messages_on_player_steamid3  (player_steamid3)
#  index_messages_on_sent_at          (sent_at)
#  index_messages_on_server_id        (server_id)
#
# Foreign Keys
#
#  fk_rails_...  (server_id => servers.id)
#
FactoryBot.define do
  factory :message do
    message { 'test message' }
    player_name { 'VIORA' }
    player_steamid3 { '[U:1:94714121]' }
    player_team { 'Red' }
    sent_at { Time.now }
    server
  end
end
