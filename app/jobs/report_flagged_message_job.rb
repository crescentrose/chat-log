class ReportFlaggedMessageJob < ApplicationJob
  queue_as :default

  DISCORD_WEBHOOK_URL = ENV.fetch('DISCORD_WEBHOOK_URL', nil).freeze

  def perform(flag)
    return if DISCORD_WEBHOOK_URL.nil?

    flag = Flag.includes(message: :server).find(flag.id)

    response = Faraday.post(DISCORD_WEBHOOK_URL) do |req|
      req.params['wait'] = 'true'
      req.headers['Content-Type'] = 'application/json'
      req.body = payload(flag)
    end

    json = JSON.parse(response.body)
    flag.update(discord_webhook_id: json.dig('id'))
  end

  private

  def payload(flag)
    {
      content: '🚩 A message has been flagged for review.',
      embeds: [
        {
          description: flag.message_text,
          color: 15_158_017,
          fields: [
            {
              name: 'Server',
              value: flag.message_server,
              inline: true
            },
            {
              name: 'Steam ID',
              value: flag.message_sender_id,
              inline: true
            },
            {
              name: 'Sent at (UTC)',
              value: flag.message_sent_at,
              inline: true
            },
            {
              name: 'Context',
              value: "https://logs.viora.sh/messages/#{flag.message.id}#message_#{flag.message.id}"
            },
            {
              name: 'Resolve',
              value: "[Click here to resolve this report.](#{Rails.application.routes.url_helpers.resolve_flag_url(flag, token: flag.resolve_token)})"
            }
          ],
          author: {
            name: flag.message.player_name,
            url: "https://logs.viora.sh/messages?q%5Bfor_player%5D=#{flag.message_sender_id}"
          }
        }
      ]
    }.to_json
  end
end
