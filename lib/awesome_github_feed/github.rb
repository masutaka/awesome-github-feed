class AwesomeGithubFeed
  class Github
    def initialize(settings)
      @account = settings['account']
      @feed_token = settings['feed_token']
    end

    def feed_url
      @feed_url ||= "https://github.com/#{feed_file}?token=#{@feed_token}"
    end

    def feed_file
      @feed_file ||= "#{@account}.private.atom"
    end
  end
end
