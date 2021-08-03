require 'rails_helper'

RSpec.describe "LogFiles", type: :request do
  describe "POST /log_files" do
    let(:server) { create :server }
    let(:log_file_params) do
      {
        log_file: {
          file: fixture_file_upload('test.log'),
          server_name: server.name
        }
      }
    end

    context 'with a good file' do
      it 'creates a new log file' do
        post '/log_files', params: log_file_params
        expect(response).to have_http_status :created
      end

      it 'enqueues a processing job' do
        expect { post '/log_files', params: log_file_params }.to have_enqueued_job
      end
    end

    context 'when the endpoint is secured' do
      before { ENV['LOG_UPLOAD_PASSWORD'] = 'foobarbaz' }

      it 'requests authentication on unauthenticated request' do
        post '/log_files', params: log_file_params
        expect(response).to have_http_status :unauthorized
      end

      it 'creates a new log file on authenticated request' do
        post '/log_files', params: log_file_params, headers: { 'AUTHORIZATION' => 'Token foobarbaz' }
        expect(response).to have_http_status :created
      end

      after { ENV['LOG_UPLOAD_PASSWORD'] = nil }
    end
  end
end
