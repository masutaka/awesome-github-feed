require 'active_support/time'
require 'erb'
require 'newrelic_rpm'
require 'yaml'
require_relative 'lib/awesome_github_feed'

GC::Profiler.enable

path = File.join(__dir__, 'config', 'settings.yml')
settings = YAML.load(ERB.new(IO.read(path)).result)

AwesomeGithubFeed.new(settings).start
