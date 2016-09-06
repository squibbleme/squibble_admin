unless Rails.env.test?
  schedule_file = Rails.root.join('config', 'sidekiq', 'cron_jobs.yml')
  Sidekiq::Cron::Job.load_from_hash YAML.load_file(schedule_file)
end
