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
class LogFile < ApplicationRecord
  belongs_to :server
  has_one_attached :file
end
