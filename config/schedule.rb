# Use this file to easily define all of your cron jobs.
#
# It's helpful, but not entirely necessary to understand cron before proceeding.
# http://en.wikipedia.org/wiki/Cron

# Example:
#
# set :output, "/path/to/my/cron_log.log"
#
# every 2.hours do
#   command "/usr/bin/some_great_command"
#   runner "MyModel.some_method"
#   rake "some:great:rake:task"
# end
#
# every 4.days do
#   runner "AnotherModel.prune_old_records"
# end

# Learn more: http://github.com/javan/whenever

set :output, "/tmp/cron_whenever.log"
every 5.minutes do
  command "cd /home/deploy/aers/twitter-monitor.andersonsoares.info/current && /usr/local/bin/bundle exec ./script/rails runner -e production 'Keyword.update_twittes'"
end

#create cron to start sidekiq every reboot
every :reboot do
  command "cd /home/deploy/aers/twitter-monitor.andersonsoares.info/current && RAILS_ENV=production /usr/local/bin/bundle exec sidekiq -C /home/deploy/aers/twitter-monitor.andersonsoares.info/current/config/sidekiq.yml -P /home/deploy/aers/twitter-monitor.andersonsoares.info/current/tmp/pids/sidekiq.pid >> log/sidekiq.log 2>&1"
end

#create cron to start delayed_job every reboot
# every :reboot do
#   command "cd /home/deploy/aers/twitter-monitor.andersonsoares.info/current && RAILS_ENV=production /usr/local/bin/bundle exec ./script/delayed_job -n 2 start"
# end