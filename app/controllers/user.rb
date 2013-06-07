get '/new_user' do
  erb :new_user
end

post '/user/create' do
  @user = User.create(params)
  session[:user_id] = @user.id 
  redirect "/user/#{session[:user_id]}"
end

get '/user/login' do
  erb :user_login
end

post '/user/login' do
  user = User.authenticate(params[:email], params[:password])
  if user
    session[:user_id] = user.id
    redirect "/user/#{user.id}"
  else
    redirect "/"
  end
end

get '/user/:id' do
  p "params: #{params}      | session: #{session[:user_id]}"

  if session[:user_id] == params[:id].to_i
    @user = User.find(session[:user_id])
    erb :view_user
  else
    redirect '/'
  end
end

get '/user/logout' do
  session.clear
  redirect '/'
end

