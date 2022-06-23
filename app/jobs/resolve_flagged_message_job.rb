class ResolveFlaggedMessageJob < ApplicationJob
  queue_as :default

  DISCORD_WEBHOOK_URL = ENV.fetch('DISCORD_WEBHOOK_URL', nil).freeze

  def perform(flag)
    return if DISCORD_WEBHOOK_URL.nil?

    flag = Flag.includes(message: :server).find(flag.id)

    Faraday.patch(
      "#{DISCORD_WEBHOOK_URL}/messages/#{flag.discord_webhook_id}",
      payload(flag),
      'Content-Type' => 'application/json'
    )
  end

  private

  def payload(flag)
    {
      content: "✅ Automatic report resolved! #{encouragement}",
      embeds: [
        {
          description: flag.message_text,
          color: 34995,
          author: {
            name: flag.message.player_name,
            url: "https://logs.viora.sh/messages?q%5Bfor_player%5D=#{flag.message_sender_id}"
          }
        }
      ]
    }.to_json
  end

  def encouragement
    [
      'You are awesome.',
      'Thanks for helping out!',
      'The world is a slightly nicer place.',
      'You can take a break now.',
      "Don't forget to hydrate!",
      'Also, posture check, please.',
      'Stay excellent.',
      'Thank you! :purple_heart:',
      'They will not be missed.',
      'You have done an excellent job.',
      'We are grateful for your contribution.',
      'We appreciate it!',
      'Amazingly done!',
      'I may be just a bot, but I assure you that my appreciation is genuine.',
      'Keep up the great work!',
      'You are doing good work!',
      'Awesome work today!',
      'The community thanks you.',
      'Nicely done!',
      'We are lucky to have you.',
      'You are a star! :star:',
      'Thank you for your contribution!',
      'This is an encouragement. Consider yourself encouraged.',
      'And what a joyful day it is!',
      'Stay frosty.',
      'The work never ends.',
      'Perhaps, some day, this will not be necessary.',
      'Or is it? :trolley:',
      'Now we wait for them to mald in appeals :UTmod:',
      'I am so very proud of you for sticking through this.',
      'YOU ARE CREDIT TO TEAM',
      'Not all heroes wear capes.',
      'Yep, this is what you signed up for.',
      'No, it does not get better.',
      'These encouragement messages are getting quite repetitive and annoying, are they not?',
      'You are contributing to the number one TF2 experience in the world!',
      'Someone better can join the server now.',
      'Remember: every time you resolve a report, God saves a kitten.',
      'Remember: every time you resolve a report, a baby\'s eyes shine.',
      'Remember: every time you resolve a report, an angel smiles.',
      'Remember: every time you resolve a report, Elon Musk steps on a lego.',
      'Remember: every time you resolve a report, a report is resolved.',
      'I hope this does not make them cry!',
      'Feels good, does it not?',
      'Also subscribe to Lia_Rein on Twitch.',
      'PUNISHMENT.',
      'They were probably a sniper main, too.',
      'Now for a well earned break.',
      'I love autocracy.'
    ].sample
  end
end
