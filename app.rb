require 'active_support/time'
require 'erb'
require 'newrelic_rpm'
require 'sinatra'
require 'yaml'
require_relative 'lib/awesome_github_feed'

path = File.join(__dir__, 'settings.yml')
settings = YAML.load(ERB.new(IO.read(path)).result)

configure do
  set static_cache_control: :no_cache

  pid_file = File.join('tmp', 'pids', 'app.pid')

  File.open(pid_file, 'w') {|f| f.write Process.pid }

  Signal.trap(:INT) do
    File.delete(pid_file)
  end
end

awesome_github_feed = AwesomeGithubFeed.new(settings)
github = awesome_github_feed.github

get "/#{github.feed_file}" do
  pass if params[:token].nil?
  pass unless params[:token] == github.feed_url_query['token']
  File.read(awesome_github_feed.feed_path)
end
