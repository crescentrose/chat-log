# == Schema Information
#
# Table name: log_files
#
#  id         :bigint           not null, primary key
#  processed  :boolean          default(FALSE), not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  server_id  :bigint           not null
#
# Indexes
#
#  index_log_files_on_server_id  (server_id)
#
# Foreign Keys
#
#  fk_rails_...  (server_id => servers.id)
#
require 'rails_helper'

RSpec.describe LogFile, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
