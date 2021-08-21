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

    last_log_sync = if server.last_log_sync
                     "#{time_ago_in_words(server.last_log_sync)} ago"
                   else
                     'never'
                   end

    content_tag :div, nil,
      class: "d-inline-block p-2 bg-#{background} rounded-circle",
      data: { bs_toggle: 'tooltip' },
      title: "Last status update #{last_updated}, last log sync #{last_log_sync}"
  end
end
