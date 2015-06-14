# ここから
require 'active_support/time'
require 'erb'
require 'yaml'

path = File.join(__dir__, 'settings.yml')

settings = YAML.load(ERB.new(IO.read(path)).result)

# ここまでの重複を何とかする

require 'sinatra'

feed_url = URI.parse(settings['feed_url'])
feed_file = File.basename(feed_url.path)
url_query = Hash[*feed_url.query.sub('=', ' ').split.map{|e| e.split(':')}.flatten]

get "/#{feed_file}" do
  # URL Query に token が含まれていること前提になっているので、何とかする
  pass unless params[:token] == url_query[:token]
  File.read(feed_file)
end
