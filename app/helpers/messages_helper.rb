module MessagesHelper
  def team_color(team_name, message)
    content_tag :span, message, class: "team-colored team-#{team_name.downcase}"
  end

  def steam_url(steam_id64)
    "https://steamcommunity.com/profiles/#{steam_id64}"
  end
end
