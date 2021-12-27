# == Schema Information
#
# Table name: stac_events
#
#  id              :bigint           not null, primary key
#  message         :text             not null
#  player_steamid3 :string
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  server_id       :bigint           not null
#
# Indexes
#
#  index_stac_events_on_server_id  (server_id)
#
# Foreign Keys
#
#  fk_rails_...  (server_id => servers.id)
#
require 'rails_helper'

RSpec.describe StACEvent, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
