class Slack::PingWorker
  include Sidekiq::Worker
  sidekiq_options queue: Settings.sidekiq.default_queue,
                  retry: false

  def perform(webhook_url, message, options = {})
    options.symbolize_keys!
    notifier = Slack::Notifier.new(webhook_url, username: (options[:username] || 'Slack::PingWorker'))
    notifier.ping message
  end
end
