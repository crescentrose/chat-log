# == Schema Information
#
# Table name: log_files
#
#  id         :bigint           not null, primary key
#  body       :text             not null
#  map_name   :string           not null
#  status     :enum             default("new"), not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  server_id  :bigint           not null
#
# Indexes
#
#  index_log_files_on_server_id  (server_id)
#  index_log_files_on_status     (status)
#
# Foreign Keys
#
#  fk_rails_...  (server_id => servers.id)
#
FactoryBot.define do
  factory :log_file do
    server
    map_name { 'koth_harvest_final' }
    body { '' }
    status { :new }
  end
end
