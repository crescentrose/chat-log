require 'rails_helper'

RSpec.describe 'Messages', type: :request do
  let!(:message) { create(:message, message: 'hex smells', sent_at: 30.minutes.ago) }
  let!(:message2) { create(:message, message: 'viora smells', player_name: 'hexerii', player_steamid3: '[U:1:189701717]', sent_at: 30.minutes.ago) }

  describe 'GET /messages' do
    it 'renders the messages list' do
      get '/messages'
      expect(response).to have_http_status(:ok)
      expect(response.body).to include('hex smells')
    end

    context 'filters the message list' do
      it 'by user name' do
        get '/messages', params: { q: { player_name_cont: 'VIORA' } }
        expect(response.body).to include('hex smells')
        expect(response.body).to_not include('viora smells')
      end

      it 'by steamid3' do
        get '/messages', params: { q: { for_player: '[U:1:189701717]' } }
        expect(response.body).to include('viora smells')
        expect(response.body).to_not include('hex smells')
      end

      it 'by steamid64' do
        get '/messages', params: { q: { for_player: '76561198149967445' } }
        expect(response.body).to include('viora smells')
        expect(response.body).to_not include('hex smells')
      end

      it 'by contents' do
        get '/messages', params: { q: { message_cont: 'smells' } }
        expect(response.body).to include('viora smells')
        expect(response.body).to include('hex smells')
      end

      it 'by server' do
        get '/messages', params: { q: { server_name_eq: message.server.name } }
        expect(response).to have_http_status(:ok)
        expect(response.body).to include('hex smells')
        expect(response.body).to_not include('viora smells')
      end
    end
  end

  describe 'GET /messages/:id' do
    it 'renders the message' do
      get "/messages/#{message.id}"
      expect(response).to have_http_status(:ok)
      expect(response.body).to include('hex smells')
      expect(response.body).to_not include('viora smells')
    end
  end
end

