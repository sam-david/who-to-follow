get '/' do
  # Look in app/views/index.erb
  erb :index
end

post '/add_todo' do
  if request.xhr?
    new_todo = Todo.create(todo_content: params[:todo_content])
    content_type :JSON
    new_todo.to_json
  else
    new_todo = Todo.create(todo_content: params[:todo_content])
  end
end

put '/todos/:id' do
  if request.xhr?
    todo = Todo.find(params[:id])
    todo.update_attributes(params[:todo])
    content_type :JSON
    todo.to_json
  end
end


delete '/todos/:id' do
  if request.xhr?
    todo = Todo.find(params[:id]).destroy
    content_type :JSON
    todo.to_json
  end
end
