require 'rails_helper'

RSpec.describe 'ConnectionEvents', type: :request do
  let!(:connection) { create(:connection_event, ip: '192.168.1.2') }
  let!(:connection2) { create(:connection_event, player_name: 'Darwin', player_steamid3: '[U:1:80917394]', ip: '192.168.1.1') }

  describe 'GET /connection_events' do
    context 'as admin' do
      before do
        login_as(steam_id64: '76561198054979849', nickname: 'VIORA', role: Role.admin)
      end

      it 'renders the connections list' do
        get '/connection_events'
        expect(response).to have_http_status(:ok)
        expect(response.body).to include('192.168.1.2')
        expect(response.body).to include('192.168.1.1')
      end

      context 'connections the message list' do
        it 'by user name' do
          get '/connection_events', params: { q: { player_name_cont: 'VIORA' } }
          expect(response).to have_http_status(:ok)
          expect(response.body).to include('192.168.1.2')
          expect(response.body).to_not include('192.168.1.1')
        end

        it 'by steamid3' do
          get '/connection_events', params: { q: { for_player: '[U:1:80917394]' } }
          expect(response).to have_http_status(:ok)
          expect(response.body).to include('192.168.1.1')
          expect(response.body).to_not include('192.168.1.2')
        end

        it 'by steamid64' do
          get '/connection_events', params: { q: { for_player: '76561198041183122' } }
          expect(response).to have_http_status(:ok)
          expect(response.body).to include('192.168.1.1')
          expect(response.body).to_not include('192.168.1.2')
        end

        it 'by IP' do
          get '/connection_events', params: { q: { ip_eq: '192.168.1.2' } }
          expect(response).to have_http_status(:ok)
          expect(response.body).to include('192.168.1.2')
          expect(response.body).to_not include('192.168.1.1')
        end

        it 'by server' do
          get '/connection_events', params: { q: { server_name_eq: connection.server.name } }
          expect(response).to have_http_status(:ok)
          expect(response.body).to include('192.168.1.2')
          expect(response.body).to_not include('192.168.1.1')
        end
      end

      context 'as regular user' do
        before do
          login_as(steam_id64: '76561198041183122', nickname: 'Darwin')
        end

        it 'redirects to home' do
          get '/connection_events'
          expect(response).to redirect_to('/')
          follow_redirect!
          expect(response.body).to include('You are not allowed to do this.')
        end
      end
    end
  end
end
