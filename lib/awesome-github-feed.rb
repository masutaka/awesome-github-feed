require 'clockwork'
require 'logger'
require 'open-uri'
require 'rexml/document'

class AwesomeGithubFeed
  def initialize(settings)
    @feed_url = settings['feed_url']
    @exclusion_keyword = settings['exclusion_keyword']
    @path_to_output = settings['path_to_output']
    @element_name = settings['element_name']
    @fetch_interval_seconds = settings['fetch_interval_seconds']
    @logger = Logger.new(STDOUT)
  end

  def start
    Clockwork::handler {|job| send(job)}
    Clockwork::every(@fetch_interval_seconds, :create)
  end

  private

  def create
    doc = REXML::Document.new(open(@feed_url))
    @logger.info("fetch #{@feed_url}")

    doc.context[:attribute_quote] = :quote
    root = doc.root

    root.elements.each do |element|
      next unless element.name == @element_name
      next unless element.to_s.include?(@exclusion_keyword)
      root.delete_element(element)
    end

    File.open(@path_to_output, 'w') do |outfile|
      doc.write(outfile)
      @logger.info("create #{@path_to_output}")
    end
  end
end
