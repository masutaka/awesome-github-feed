# config valid only for current version of Capistrano
lock '3.4.0'

set :application, 'awesome-github-feed'
set :repo_url, 'git@github.com:masutaka/awesome-github-feed.git'

# Default branch is :master
# ask :branch, `git rev-parse --abbrev-ref HEAD`.chomp

# Default deploy_to directory is /var/www/my_app_name
set :deploy_to, '/var/www/vhosts/github.masutaka.net'

# Default value for :scm is :git
# set :scm, :git

# Default value for :format is :pretty
# set :format, :pretty

# Default value for :log_level is :debug
set :log_level, ENV.fetch('LOG_LEVEL', :info)

# Default value for :pty is false
# set :pty, true

# Default value for :linked_files is []
# set :linked_files, fetch(:linked_files, []).push('config/database.yml', 'config/secrets.yml')

# Default value for linked_dirs is []
set :linked_dirs, %w{contents log tmp vendor/bundle}

# Default value for default_env is {}
set :default_env, { 'NEW_RELIC_ENV' => 'production' }

# Default value for keep_releases is 5
# set :keep_releases, 5

set :bundle_path, -> { shared_path.join('vendor', 'bundle') }
set :clockwork_file, -> { 'clockwork.rb' }

after 'deploy:updated', 'newrelic:notice_deployment'

namespace :deploy do
  desc 'Get settings.yml'
  before :updated, :setting_file do
    on roles(:all) do
      # Use `capture` instead of `execute` for not displaying environment variables in CircleCI
      capture "cd #{release_path} && curl -Ls -o settings.yml #{ENV.fetch('SETTINGS_FILE_PATH')}"
      capture "cd #{release_path} && curl -Ls -o config/newrelic.yml #{ENV.fetch('NEWRELIC_FILE_PATH')}"
    end
  end

  desc 'Restart applications'
  after :publishing, :restart do
    on roles(:app) do
      invoke 'sinatra:stop'
      invoke 'sinatra:start'
    end
  end
end
