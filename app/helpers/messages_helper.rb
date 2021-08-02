module MessagesHelper
  def team_color(team_name, message)
    content_tag :span, message, class: "team-colored team-#{team_name.downcase}"
  end
end
