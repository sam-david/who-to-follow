
get '/' do
  @twitter_users = []
  erb :index
end

get '/tweets/search/:category_name' do

  top_users = TwitterApi.search_category(params[:category_name])
  TwitterApi.save_users_to_database(top_users, params[:category_name])
  category = Category.where(name: params[:category_name]).first
  @twitter_users = User.where(categories: category.id)
  erb :index
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
