# == Schema Information
#
# Table name: servers
#
#  id                 :bigint           not null, primary key
#  friendly_name      :string           not null
#  ip                 :string           not null
#  is_active          :boolean          default(TRUE), not null
#  last_log_sync      :datetime
#  last_update        :datetime
#  last_uploaded_file :string
#  map                :string
#  name               :string           not null
#  players            :integer
#  port               :integer          default(27015), not null
#  rcon_password      :string
#  timezone           :string           default("UTC")
#  upload_token       :string
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  server_group_id    :bigint
#
# Indexes
#
#  index_servers_on_server_group_id  (server_group_id)
#
# Foreign Keys
#
#  fk_rails_...  (server_group_id => server_groups.id)
#
FactoryBot.define do
  factory :server do
    sequence(:name) { |n| "test-#{n}" }
    timezone { 'UTC' }
    friendly_name { 'Test Server' }
    ip { 'server.example.com' }
    port { 27015 }
    upload_token { 'foobar' }
    server_group
  end
end
