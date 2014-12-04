
get '/' do
  # Look in app/views/index.erb
  @twitter_users = []
  erb :index
end

get '/tweets/search/:category_name' do
  # TwitterApi.oauth_second_try()
  # client = Oauthclient.new(
  # consumer_key: ENV['CONSUMER_KEY'],
  # consumer_secret: ENV['CONSUMER_SECRET'],
  # token: ENV['ACCESS_TOKEN'],
  # token_secret: ENV['ACCESS_TOKEN_SECRET'])
  content_type :json
  TwitterApi.get("https://api.twitter.com/1.1/statuses/user_timeline.json?count=3&screen_name=devbootcamp")
  # client = TwitterApi.get("https://api.twitter.com/1.1/statuses/user_timeline.json?count=1&screen_name=devbootcamp")
  # client = TwitterApi.set_client
  # TwitterApi.search_category(client, params[:category_name])
end



# post '/add_todo' do
#   if request.xhr?
#     new_todo = Todo.create(todo_content: params[:todo_content])
#     content_type :JSON
#     new_todo.to_json
#   else
#     new_todo = Todo.create(todo_content: params[:todo_content])
#   end
# end

# put '/todos/:id' do
#   if request.xhr?
#     todo = Todo.find(params[:id])
#     todo.update_attributes(params[:todo])
#     content_type :JSON
#     todo.to_json
#   end
# end


# delete '/todos/:id' do
#   if request.xhr?
#     todo = Todo.find(params[:id]).destroy
#     content_type :JSON
#     todo.to_json
#   end
# end
