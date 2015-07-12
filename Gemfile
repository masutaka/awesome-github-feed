source 'https://rubygems.org'
ruby '2.2.2'

gem 'activesupport'
gem 'clockwork'
gem 'daemons'
gem 'newrelic_rpm'
gem 'sinatra'

group :development do
  gem 'capistrano', require: false
  gem 'capistrano-bundler', require: false
  gem 'capistrano-clockwork', require: false, github: 'masutaka/capistrano-clockwork', branch: 'add-option-dir'
  gem 'pushover', require: false
end

group :development, :test do
  gem 'pry'
  gem 'rack-test'
  gem 'rspec'
end
