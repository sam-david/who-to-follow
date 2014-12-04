
# env gem. heroku config --help
# require dotenv
# ENV["Twitter_key"]
# git ignore the .env file
# entities for twitter earch
# user .where instead of .find
# load 'twitter_config.rb'

module TwitterApi

  def self.search_category(category)
    case category
    when "tech"
      url_builder("tech")
    when "music"
      url_builder("music")
    when "sports"
      url_builder("sports")
    when "photo"
      url_builder("photography")
    when "enterainment"
      url_builder("entertainment")
    when "news"
      url_builder("news")
    when "fashion"
      url_builder("fashion")
    when "food"
      url_builder("food")
    when "television"
      url_builder("television")
    when "movies"
      url_builder("movies")
    when "family"
      url_builder("family")
    when "art"
      url_builder("art")
    when "business"
      url_builder("business")
    when "finance"
      url_builder("finance")
    when "health"
      url_builder("health")
    when "books"
      url_builder("books")
    when "science"
      url_builder("science")
    when "faith"
      url_builder("faith")
    when "government"
      url_builder("government")
    when "social_good"
      url_builder("social_good")
    when "travel"
      url_builder("travel")
    when "gaming"
      url_builder("gaming")
    when "nba"
      url_builder("nba")
    when "nfl"
      url_builder("nfl")
    when "mlb"
      url_builder("mlb")
    when "nascar"
      url_builder("finance")
    when "nhl"
      url_builder("finance",40)
    when "pga"
      url_builder("pga",40)
    end
  end

  def self.url_builder(hashtags, count = 55)
    api_request("https://api.twitter.com/1.1/search/tweets.json?q=%23#{hashtags}&since_id=24012619984051000&result_type=recent&count=#{count}")
  end

  def self.set_oauth_client
    # @credentials = (
    #   consumer_key: ENV['CONSUMER_KEY'],
    #   consumer_secret: ENV['CONSUMER_SECRET'],
    #   token: ENV['ACCESS_TOKEN'],
    #   token_secret: ENV['ACCESS_TOKEN_SECRET'])
    # return @credentials
  end

  def self.api_request(api_request_url)
    uri = URI.parse(api_request_url)
    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true
    request = Net::HTTP::Get.new(uri)
    request["Authorization"] = oauth_header(request, {consumer_key: ENV['CONSUMER_KEY'], consumer_secret: ENV['CONSUMER_SECRET'], token: ENV['ACCESS_TOKEN'], token_secret: ENV['ACCESS_TOKEN_SECRET']})
    response = http.request(request)
    parse_tweet(response)
  end

  def self.parse_tweet(response)
    parsed_tweet = JSON.parse(response.body)
    all_users = []
    parsed_tweet["statuses"].each_with_index do |tweet, index|
      user_hash = {}
      user_hash[:name] = tweet["user"]["name"]
      user_hash[:screen_name] = tweet["user"]["screen_name"]
      user_hash[:followers_count] = tweet["user"]["followers_count"]
      user_hash[:following_count] = tweet["user"]["friends_count"]
      user_hash[:statuses_count] = tweet["user"]["statuses_count"]
      user_hash[:message] = tweet["text"]
      hashtags = []
      tweet["entities"]["hashtags"].each do |hashtag|
        hashtags << hashtag["text"]
      end
      user_hash[:hashtags] = hashtags.join(' ')
      user_hash[:type] = tweet["metadata"]["result_type"]
      user_hash[:image_url] = tweet["user"]["profile_image_url"]
      all_users << user_hash
      p index + 1
    end
    filter_top_users(all_users)
  end

  def self.filter_top_users(all_users)
    index = all_users.length * 0.70
    sorted_users = all_users.sort_by { |user| user[:followers_count] }
    return sorted_users[index..all_users.length].reverse
  end

  def self.oauth_header(request, credentials)
    SimpleOAuth::Header.new(request.method, request.uri, URI.decode_www_form(request.body.to_s), credentials).to_s
  end


end