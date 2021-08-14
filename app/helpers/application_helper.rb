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
end
