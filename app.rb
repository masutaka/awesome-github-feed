# ここから
require 'active_support/time'
require 'erb'
require 'yaml'

path = File.join(__dir__, 'settings.yml')

settings = YAML.load(ERB.new(IO.read(path)).result)

# ここまでの重複を何とかする

require 'sinatra'

configure do
  set static_cache_control: :no_cache

  pid_file = File.join('tmp', 'app.pid')

  File.open(pid_file, 'w') {|f| f.write Process.pid }

  Signal.trap(:INT) do
    File.delete(pid_file)
  end
end

require_relative 'lib/github'

github = AwesomeGithubFeed::Github.new(settings['github'])

feed_url = URI.parse(github.feed_url)
feed_file = File.basename(feed_url.path)
url_query = Hash[*feed_url.query.sub('=', ' ').split.map{|e| e.split(':')}.flatten]

get "/#{feed_file}" do
  # URL Query に token が含まれていること前提になっているので、何とかする
  pass unless params[:token] == url_query[:token]
  File.read(feed_file)
end
