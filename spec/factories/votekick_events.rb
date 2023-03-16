# == Schema Information
#
# Table name: votekick_events
#
#  id                 :bigint           not null, primary key
#  initiator_steamid3 :string
#  target_name        :string
#  target_steamid3    :string
#  time               :datetime
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  server_id          :bigint           not null
#
# Indexes
#
#  index_votekick_events_on_initiator_steamid3  (initiator_steamid3)
#  index_votekick_events_on_server_id           (server_id)
#  index_votekick_events_on_target_name         (target_name)
#  index_votekick_events_on_target_steamid3     (target_steamid3)
#
# Foreign Keys
#
#  fk_rails_...  (server_id => servers.id)
#
FactoryBot.define do
  factory :votekick_event do
    initiator_steamid3 { "[U:1:0]" }
    target_steamid3 { "[U:1:1]" }
    target_name { "test" }
    time { "2021-08-04 19:04:50" }
    server
  end
end
