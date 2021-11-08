class ReportFlaggedMessageJob < ApplicationJob
  queue_as :default

  DISCORD_WEBHOOK_URL = ENV.fetch('DISCORD_WEBHOOK_URL', nil).freeze

  def perform(message)
    return if DISCORD_WEBHOOK_URL.nil?

    message = Message.includes(:server).find(message.id)

    puts payload(message)

    Faraday.post(DISCORD_WEBHOOK_URL, payload(message), 'Content-Type' => 'application/json')
  end

  private

  def payload(message)
    {
      content: '🚩 A message has been flagged for review.',
      embeds: [
        {
          description: message.message.to_s,
          color: 15_158_017,
          fields: [
            {
              name: 'Server',
              value: message.server.friendly_name.to_s,
              inline: true
            },
            {
              name: 'Steam ID',
              value: message.player_steamid3.to_s,
              inline: true
            },
            {
              name: 'Sent at (UTC)',
              value: message.sent_at.strftime('%c').to_s
            },
            {
              name: 'Context',
              value: "https://logs.viora.sh/messages/#{message.id}#message_#{message.id}"
            }
          ],
          author: {
            name: message.player_name.to_s,
            url: "https://logs.viora.sh/messages?q%5Bfor_player%5D=#{message.player_steamid3}"
          }
        }
      ]
    }.to_json
  end
end
