class RedditClient

  attr_accessor :client, :response, :parsed_body

  def initialize
    self.client = Faraday.new('https://www.reddit.com/r/')
  end

  def load_posts(subreddit = 'Showerthoughts')
    posts = []
    self.response ||= self.client.get("#{subreddit}.json")

    if self.response.success?
      parsed_body = parse_body(self.response.body) 
      posts = parsed_body['data']['children']
    end

    posts
  end

  private
  
  def parse_body(body)    
    Yajl::Parser.parse(body)
  end
end