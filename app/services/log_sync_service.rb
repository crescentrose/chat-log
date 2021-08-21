class LogSyncService
  MONITOR_PATH = '/home/tf2server/serverfiles/tf/logs'.freeze

  def initialize(logger=nil)
    @logger = logger || Rails.logger
  end

  def sync(server)
    raise 'ssh key missing' if server.ssh_key.nil?
    last_update = format_time(server.last_log_sync_local || 1.day.ago)

    Net::SSH.start(server.ip, 'tf2server', key_data: [server.private_key], keys_only: true, verify_host_key: :never) do |connection|
      files = connection.exec!(
        "find \"#{MONITOR_PATH}\" -maxdepth 1 -type f -newermt \"#{last_update}\" -printf '%T@ %p\n'"
      )

      file_list_from_find(files, server.timezone)
        .tap { |files| logger.info("[#{server.name}] downloading #{files.size} new files since last update") }
        .map { |filename| connection.scp.download!(filename) }
        .map do |log_data|
          log_file = LogFile.create!(server: server, processed: false)
          log_file.file.attach(
            io: StringIO.new(log_data),
            filename: 'tf2.log',
            content_type: 'text/plain'
          )
          log_file
        end
        .map { |log_file| ParseLogFileJob.perform_later(log_file) }
    end

    server.update!(last_log_sync: Time.now)
  end

  private

  attr_reader :logger

  def format_time(time)
    time.strftime('%F %T')
  end

  def file_list_from_find(files, timezone)
    files
      .split("\n")
      .map { |file| ServerFile.new(file, timezone) }
      .sort_by { |file| file.modified_at }
      .reverse
      .drop(1) # assume the most recent file is active currently
      .map(&:name)
  end

  class ServerFile
    attr_reader :modified_at, :name

    def initialize(name_with_time, timezone)
      Time.zone = timezone
      components = name_with_time.split(' ')
      @modified_at = Time.zone.at(components[0].to_f)
      @name = components[1..].join(' ')
    end
  end
end
