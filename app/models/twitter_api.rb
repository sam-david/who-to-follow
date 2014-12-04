
# env gem. heroku config --help
# require dotenv
# ENV["Twitter_key"]
# git ignore the .env file
# entities for twitter earch
# user .where instead of .find
# load 'twitter_config.rb'

module TwitterApi
  attr_reader :credentials



  def self.set_client
    p "set client"
    @client = Twitter::REST::Client.new do |config|
    config.consumer_key = ENV['CONSUMER_KEY']
    config.consumer_secret = ENV['CONSUMER_SECRET']
    config.access_token = ENV['ACCESS_TOKEN']
    config.access_token_secret = ENV['ACCESS_TOKEN_SECRET']
    end
    return @client
  end

  def self.search_query(client, search_words)
    count = 0
    tweets = client.search("##{search_words} -rt", :count => 5)

    tweets.each do |tweet|
      count += 1
      p tweet
    end
    p count
  end

  def self.search_category(client, category)
    p "searching"
    case category
    when "tech"
      search_query(client, "#tech")
    when "music"
      search_query(client, "#music")
    when "sports"
      search_query(client, "#sports")
    when "photo"
      search_query(client, "#photography")
    when "enterainment"
      search_query(client, "#entertainment")
    when "news"
      search_query(client, "#news")
    when "fashion"
      search_query(client, "#fasion")
    when "food"
      search_query(client, "#food")
    when "television"
      search_query(client, "#television")
    when "movies"
      search_query(client, "#movies")
    when "family"
      search_query(client, "#family")
    when "art"
      search_query(client, "#art")
    when "business"
      search_query(client, "#business")
    when "finance"
      search_query(client, "#finance")
    when "health"
      search_query(client, "#finance")
    when "books"
      search_query(client, "#finance")
    when "science"
      search_query(client, "#finance")
    when "faith"
      search_query(client, "#finance")
    when "government"
      search_query(client, "#finance")
    when "social_good"
      search_query(client, "#finance")
    when "travel"
      search_query(client, "#finance")
    when "gaming"
      search_query(client, "#finance")
    when "nba"
      search_query(client, "#finance")
    when "nfl"
      search_query(client, "#finance")
    when "mlb"
      search_query(client, "#finance")
    when "nascar"
      search_query(client, "#finance")
    when "nhl"
      url_builder("#finance",40)
    when "pga"
      url_builder("#pga",40)
    end
  end

  def url_builder(hashtags, count)
    return "https://api.twitter.com/1.1/search/tweets.json?q=%23#{hashtags}&since_id=24012619984051000&result_type=recent&count=#{count}"
  end

  def self.set_oauth_client
    # @credentials = (
    #   consumer_key: ENV['CONSUMER_KEY'],
    #   consumer_secret: ENV['CONSUMER_SECRET'],
    #   token: ENV['ACCESS_TOKEN'],
    #   token_secret: ENV['ACCESS_TOKEN_SECRET'])
    # return @credentials

  end

  def self.get(url)
    uri = URI.parse(url)
    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true
    request = Net::HTTP::Get.new(uri)
    request["Authorization"] = oauth_header(request, {consumer_key: ENV['CONSUMER_KEY'], consumer_secret: ENV['CONSUMER_SECRET'], token: ENV['ACCESS_TOKEN'], token_secret: ENV['ACCESS_TOKEN_SECRET']})
    response = http.request(request)
    p parsed_tweet = JSON.parse(response.body)
      parsed_tweet.each_with_index do |tweet, index|
        p tweet
        p index
      end
    p parsed_tweet.class
    # p parsed_tweet['statuses'].length
    return parsed_tweet
  end

  def self.oauth_header(request, credentials)
    SimpleOAuth::Header.new(request.method, request.uri, URI.decode_www_form(request.body.to_s), credentials).to_s
  end

  def self.oauth_second_try
    consumer_key = OAuth::Consumer.new("3c7g1jIAm8UsRY1jnwL3Z9gjy",
    "AxxXrhG748n8v255zw1kaC2RaNoSBp6L1FF8bjbBqTY66ypf2D")
    access_token = OAuth::Consumer.new("207277406-qkdncHlIlIfcVVZkgjU5v9uN1sGyrtUL7TsvF1DR",
    "0Rkl6Tskx6evV3ONH1QMBj2dMOJnwxraUk9yg7IZyuoIc")

    baseurl = "https://api.twitter.com"
    path = "/1.1/statuses/show.json"
    query   = URI.encode_www_form("id" => "266270116780576768")
    address = URI("#{baseurl}#{path}?#{query}")
    request = Net::HTTP::Get.new address.request_uri

    http = Net::HTTP.new address.host, address.port
    http.use_ssl = true
    http.verify_mode = OpenSSL::SSL::VERIFY_PEER

    request.oauth! http, consumer_key, access_token
    http.start
    response = http.request request
    tweet = nil
    if response.code == '200' then
      p tweet = JSON.parse(response.body)
      # print_tweet(tweet)
    end
  end


end

# tweet_search = client.search("https://api.twitter.com/1.1/search/tweets.json?q=%23superbowl&result_type=recent")
# tweet_search.each do | tweet |
#     # p tweet.user.followers_count
#   tweets << {username: tweet.user.name, tweet_text: tweet.text, followers: tweet.user.followers_count}
#     puts "#{tweet.user.name} said #{tweet.text} Followers  #{tweet.user.status.text}"
# end

# puts client.friends.users.first

# client.search("#investing").text

# client.user do |object|
#   case object
#   when Twitter::Tweet
#     puts "It's a tweet!"
#   when Twitter::DirectMessage
#     puts "It's a direct message!"
#   when Twitter::Streaming::StallWarning
#     warn "Falling behind!"
#   end
# end
# topics = ["#coffee"]
# client.filter(:track => topics.join(",")) do |object|
#   # puts object.text
#   if object.is_a?(Twitter::Tweet)
#     puts object.text
#     puts object.created_at
#   end
# end

# tweets = []
# counter = 0
# total_followers = 0

# p client.search("#ruby -rt", :lang => "ja").first.text



# p "tweets"
# p tweets
# p "index"
# p index = tweets.length * 0.90
# p "tweets.length"
# p tweets.length
# p "sorted_tweets"
# p sorted_tweets = tweets.sort_by { |tweet| tweet[:followers] }

# p sorted_tweets[index..tweets.length]