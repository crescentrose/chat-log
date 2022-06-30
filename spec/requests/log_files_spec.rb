require 'rails_helper'

RSpec.describe 'Log files', type: :request do
  describe 'POST /upload' do
    let(:server) { create(:server) }
    let(:sample_log) do
      <<~LOG
      L 07/30/2021 - 22:32:42: "gamer<526><[U:1:000000526]><Red>" say "._."
      LOG
    end
    let(:auth_token) { ENV.fetch("LOG_UPLOAD_PASSWORD") }

    context 'for valid server names and with valid auth headers' do
      it 'accepts the log file' do 
        json = { 
          server_name: server.name,
          map_name: 'koth_harvest_final',
          body: sample_log 
        }.to_json

        post '/upload', params: json, headers: { 'CONTENT_TYPE' => 'application/json', 'AUTHORIZATION' => auth_token }

        expect(response).to have_http_status :accepted
      end
    end
    
    context 'for invalid server names' do
      it 'responds with 401' do
        json = { 
          server_name: 'foobarbaz',
          map_name: 'koth_harvest_final',
          body: sample_log
        }.to_json

        post '/upload', params: json, headers: { 'CONTENT_TYPE' => 'application/json', 'AUTHORIZATION' => auth_token }

        expect(response).to have_http_status :bad_request
      end
    end

    context 'without required fields' do
      it 'responds with 401' do
        json = { 
          body: sample_log
        }.to_json

        post '/upload', params: json, headers: { 'CONTENT_TYPE' => 'application/json', 'AUTHORIZATION' => auth_token }

        expect(response).to have_http_status :bad_request
      end
    end

    context 'when wrong authentication headers are provided' do
      it 'responds with 403' do
        json = {
          server_name: server.name,
          map_name: 'koth_harvest_final',
          body: sample_log
        }.to_json

        post '/upload', params: json, headers: { 'CONTENT_TYPE' => 'application/json', 'AUTHORIZATION' => 'raspy smells' }

        expect(response).to have_http_status :forbidden
      end
    end
  end
end


