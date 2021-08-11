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
  after_save :cleanup, if: ->{ processed? }

  def contents
    file.open do |tempfile|
      # We get a byte stream back from ActiveStorage for some cursed reason
      # this assembles that byte stream back into holy, God given UTF-8
      tempfile.read.bytes.pack("c*").force_encoding('utf-8')
    end
  end

  private

  def cleanup = file.purge_later
end
