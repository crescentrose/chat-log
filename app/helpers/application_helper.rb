module ApplicationHelper
  # Popular TF2 server timezones
  # West Coast, Central US, East Coast, GMT and CET.
  def default_timezones
    [
      ActiveSupport::TimeZone['Pacific Time (US & Canada)'],
      ActiveSupport::TimeZone['Mountain Time (US & Canada)'],
      ActiveSupport::TimeZone['Central Time (US & Canada)'],
      ActiveSupport::TimeZone['Eastern Time (US & Canada)'],
      ActiveSupport::TimeZone['UTC'],
      ActiveSupport::TimeZone['London'],
      ActiveSupport::TimeZone['Berlin'],
    ]
  end

  def health_badge(server)
    background = case server.health
                 when :ok
                   'success'
                 when :status_only
                   'primary'
                 when :warn
                   'warning'
                 when :critical
                   'danger'
                 when :offline
                   'secondary'
                 end

    last_updated = if server.last_update
                     "#{time_ago_in_words(server.last_update)} ago"
                   else
                     'never'
                   end
    
    cause = case server.health
            when :ok
              'Server was recently updated and reported map and player count data.'
            when :status_only
              'Server was not set up for remote access, but it is still tracked.'
            when :warn, :critical
              "This server is set up for remote access, but was last seen #{last_updated}."
            when :offline
              'Server has been disabled.'
            end

    content_tag :div, nil,
      class: "d-inline-block p-2 bg-#{background} rounded-circle",
      data: { bs_toggle: 'tooltip' },
      title: cause
  end
end
