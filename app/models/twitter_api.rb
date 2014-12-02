
# env gem. heroku config --help
# require dotenv
# ENV["Twitter_key"]
# git ignore the .env file
# entities for twitter earch
# user .where instead of .find
# load 'twitter_config.rb'

module TwitterApi

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

  def self.quick_search(client)
    p "searching"
    p client.search("#tech -rt").first.user
  end
end

# p search = client.search("#tech -rt")
# p client.search("#tech -rt").first.user


# client.sample do |object|
#   puts object.text if object.is_a?(Twitter::Tweet)
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

# tweet_search = client.search("https://api.twitter.com/1.1/search/tweets.json?q=%23superbowl&result_type=recent")
# tweet_search.each do | tweet |
#     # p tweet.user.followers_count
#   tweets << {username: tweet.user.name, tweet_text: tweet.text, followers: tweet.user.followers_count}
#     puts "#{tweet.user.name} said #{tweet.text} Followers  #{tweet.user.status.text}"
# end

# p "tweets"
# p tweets
# p "index"
# p index = tweets.length * 0.90
# p "tweets.length"
# p tweets.length
# p "sorted_tweets"
# p sorted_tweets = tweets.sort_by { |tweet| tweet[:followers] }

# p sorted_tweets[index..tweets.length]