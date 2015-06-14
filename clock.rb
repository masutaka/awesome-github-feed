require 'active_support/time'
require 'erb'
require 'yaml'

path = File.join(__dir__, 'settings.yml')

settings = YAML.load(ERB.new(IO.read(path)).result)

require_relative 'lib/awesome-github-feed'

AwesomeGithubFeed.new(settings).start
