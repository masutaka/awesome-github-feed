require 'active_support/time'
require 'erb'
require 'newrelic_rpm'
require 'yaml'
require_relative 'lib/awesome_github_feed'

path = File.join(__dir__, 'settings.yml')
settings = YAML.load(ERB.new(IO.read(path)).result)

AwesomeGithubFeed.new(settings).start
