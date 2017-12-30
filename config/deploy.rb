# config valid for current version and patch releases of Capistrano
lock '~> 3.10.1'

set :application, 'pushkin'
set :repo_url, 'git@github.com:vadia2pac/pushkin-contest-bot.git'

# Default branch is :master
# ask :branch, `git rev-parse --abbrev-ref HEAD`.chomp

# Default deploy_to directory is /var/www/my_app_name
set :deploy_to, '/var/www/pushkin/'

# Default value for :format is :airbrussh.
# set :format, :airbrussh

# You can configure the Airbrussh format using :format_options.
# These are the defaults.
set :format_options, command_output: true, log_file: 'log/capistrano.log', color: :auto, truncate: :auto

# Default value for :pty is false
set :pty, false

# Default value for :linked_files is []
append :linked_files, 'config/database.yml', 'config/secrets.yml'

# Default value for linked_dirs is []
append :linked_dirs, 'log', 'tmp/pids', 'tmp/cache', 'tmp/sockets', 'public/system'

set :ssh_options, { :forward_agent => true }

set :rvm_ruby_version, '2.4.0@pushkin-contest-bot'

set :puma_preload_app, true
set :puma_init_active_record, true
# set :puma_bind, "unix:///var/www/pushkin/shared/sockets/puma.sock"
