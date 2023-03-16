require 'rails_helper'

RSpec.describe 'VotekickEvents', type: :request do
  let!(:votekick_event) { create(:votekick_event) }

  describe 'GET /votekick_events' do
    context 'as admin' do
      before do
        login_as(steam_id64: '76561198054979849', nickname: 'VIORA', role: Role.admin)
      end

      it 'renders the votekick list' do
        get '/votekick_events'
        expect(response).to have_http_status(:ok)
        expect(response.body).to include('76561197960265729')
        expect(response.body).to include('76561197960265728')
      end

      context 'as regular user' do
        before do
          login_as(steam_id64: '76561198041183122', nickname: 'Darwin')
        end

        it 'redirects to home' do
          get '/votekick_events'
          expect(response).to redirect_to('/')
          follow_redirect!
          expect(response.body).to include('You are not allowed to do this.')
        end
      end
    end
  end
end
