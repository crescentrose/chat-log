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
FactoryBot.define do
  factory :log_file do
    file { Rack::Test::UploadedFile.new(Rails.root + 'spec/fixtures/files/test.log', 'text/plain') }
    server
  end
end
