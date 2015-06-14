require 'pry'

get '/login' do
  erb :'/auth/_login'
end

post '/login' do
  @user = User.find_by(email:params[:user][:email])
  if @user.password == params[:user][:password]
    session[:id] = @user.id
    redirect '/decks'
  else
    @errors = "Incorrect login"
    erb :'/auth/_login'
  end
end

post '/users' do
  @user = User.new(params[:user])
  if @user.save
    session[:id] = @user.id
    redirect '/decks'
  else
    erb :signup
  end
end

get '/logout' do
  session[:id] = nil
  redirect '/login'
end