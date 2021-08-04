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
    server

    transient do
      contents { nil }
      tempfile { Tempfile.new('logfile') }
    end

    before(:create) do |log_file, evaluator|
      if evaluator.contents.nil?
        log_file.file = Rack::Test::UploadedFile.new(Rails.root + 'spec/fixtures/files/test.log', 'text/plain')
      else
        evaluator.tempfile.write(evaluator.contents)
        evaluator.tempfile.close
        log_file.file = Rack::Test::UploadedFile.new(evaluator.tempfile.path, 'text/plain')
      end
    end

    after(:create) do |log_file, evaluator|
      evaluator.tempfile.unlink
    end
  end
end
