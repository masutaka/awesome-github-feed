require 'clockwork'
require 'logger'
require 'open-uri'
require 'rexml/document'
require_relative 'awesome_github_feed/github'

class AwesomeGithubFeed
  attr_reader :github

  def initialize(settings)
    @github = Github.new(settings['github'])
    @exclusion_keyword = settings['exclusion_keyword']
    @element_name = settings['element_name']
    @fetch_interval_seconds = settings['fetch_interval_seconds']
    @output_dir = settings['output_dir']
    @logger = Logger.new(STDOUT)
  end

  def start
    Clockwork::handler {|job| send(job)}
    Clockwork::every(@fetch_interval_seconds, :create)
  end

  def feed_path
    @feed_path ||= File.join(@output_dir, @github.feed_file)
  end

  private

  def create
    doc = REXML::Document.new(open(@github.feed_url))
    @logger.info("fetch #{@github.feed_url}")

    doc.context[:attribute_quote] = :quote
    root = doc.root

    root.elements.each do |element|
      next unless element.name == @element_name
      next unless element.to_s.include?(@exclusion_keyword)
      root.delete_element(element)
    end

    File.open(feed_path, 'w') do |outfile|
      doc.write(outfile)
      @logger.info("create #{feed_path}")
    end
  end
end
