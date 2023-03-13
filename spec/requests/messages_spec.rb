require 'rails_helper'

RSpec.describe 'Messages', type: :request do
  let!(:message) { create(:message, message: 'hex smells', sent_at: 30.minutes.ago) }
  let!(:message2) { create(:message, message: 'viora smells', player_name: 'hexerii', player_steamid3: '[U:1:189701717]', sent_at: 30.minutes.ago) }
  let!(:message3) { create(:message, message: 'meow', player_name: 'Squibbed', player_steamid3: '[U:1:88904632]', sent_at: 30.days.ago) }

  describe 'GET /messages' do
    context 'for old messages' do
      let(:full_messages_permission) { Permission.find_by(code: 'messages.full_index') }
      let(:messages_permission) { Permission.find_by(code: 'messages.index') }
      let(:moderator_role) { create(:role, permissions: [messages_permission, full_messages_permission]) }

      it 'retrieves them for moderators' do
        login_as(steam_id64: '76561198054979849', nickname: 'VIORA', role: moderator_role)
        get '/messages'
        expect(response.body).to include('meow')
      end

      it 'does not retrieve them for regular users' do
        login_as(steam_id64: '76561198041183122', nickname: 'Darwin', role: Role.everyone)
        get '/messages'
        expect(response.body).to_not include('meow')
      end
    end

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
        get '/messages', params: { q: { server_id_eq: message.server.id } }
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

