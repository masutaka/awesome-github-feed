require 'uri'

class AwesomeGithubFeed
  class Github
    def initialize(settings)
      @account = settings['account']
      @feed_token = settings['feed_token']
    end

    def feed_url
      @feed_url ||= "https://github.com/#{feed_file}?token=#{@feed_token}"
    end

    def feed_url_query
      @feed_url_query ||= Hash[*URI.parse(feed_url).query.sub('=', ' ').split.map{|e| e.split(':')}.flatten]
    end

    def feed_file
      @feed_file ||= "#{@account}.private.atom"
    end
  end
end
