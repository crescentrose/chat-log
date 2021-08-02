# == Schema Information
#
# Table name: messages
#
#  id              :bigint           not null, primary key
#  message         :text
#  player_name     :string
#  player_steamid3 :string
#  player_team     :string
#  sent_at         :datetime
#  team            :boolean
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  server_id       :bigint           not null
#
# Indexes
#
#  index_messages_on_server_id  (server_id)
#
# Foreign Keys
#
#  fk_rails_...  (server_id => servers.id)
#
require 'rails_helper'

RSpec.describe Message, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
