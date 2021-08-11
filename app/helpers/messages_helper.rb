module MessagesHelper
  def team_color(team_name, message)
    content_tag :span, message, class: "team-colored team-#{team_name.downcase}"
  end

  def steam_url(steam_id64)
    "https://steamcommunity.com/profiles/#{steam_id64}"
  end

  def server_tag(server)
    hue = server.id * (360 / 15) # TODO: customizable server colours
    content_tag(:span, server.name, class: 'badge', style: "background-color: hsl(#{hue}, 40%, 40%)")
  end
end
