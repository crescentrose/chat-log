module AuthHelper
  def login_as(steam_id64:, nickname:, role: Role.everyone)
    OmniAuth.config.mock_auth[:steam] =
      OmniAuth::AuthHash.new(
        {
          uid: steam_id64,
          info: {
            image: 'https://placekitten.com/64/64',
            nickname: nickname
          }
        }
      )

    post '/auth/steam/callback'

    User.for_player(steam_id64).update(role: role)

    OmniAuth.config.mock_auth[:steam] = nil
  end
end
