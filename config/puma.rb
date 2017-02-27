if ENV.fetch("RAILS_ENV") == 'production'
  # directory '/opt/iris'
  # rackup "/opt/iris/config.ru"
  # environment 'production'

  # pidfile "/tmp/iris/puma.pid"
  # state_path "/tmp/iris/puma.state"
  # stdout_redirect '/var/log/iris/puma.access.log', '/var/log/iris/puma.error.log', true

  # threads 0,16

  # bind 'unix:////tmp/iris/puma.sock'

  # workers 0

  # prune_bundler
else
  threads_count = ENV.fetch("RAILS_MAX_THREADS") { 5 }.to_i
  threads threads_count, threads_count
  port        ENV.fetch("PORT") { 3000 }
  environment ENV.fetch("RAILS_ENV") { "development" }
  # The code in the `on_worker_boot` will be called if you are using
  # clustered mode by specifying a number of `workers`. After each worker
  # process is booted this block will be run, if you are using `preload_app!`
  # option you will want to use this block to reconnect to any threads
  # or connections that may have been created at application boot, Ruby
  # cannot share connections between processes.
  #
  # on_worker_boot do
  #   ActiveRecord::Base.establish_connection if defined?(ActiveRecord)
  # end

  # Allow puma to be restarted by `rails restart` command.
  plugin :tmp_restart
end