require 'pry'

get '/login' do
  erb :'/auth/_login'
end

post '/login' do
  if @user = User.find_by(email:params[:user][:email])
    if @user.password == params[:user][:password]
      session[:id] = @user.id
      redirect '/decks'
    else
      @errors = "Incorrect login"
      erb :'/auth/_login'
    end
  else
    @errors = "You must first sign up before you can master the art of JuJoJaTAY Flash-FOO!"
    erb :'auth/_login'
  end
end

post '/users' do
  @user = User.new(params[:user])
  if @user.save
    session[:id] = @user.id
    redirect '/decks'
  else
    @errors = "You didn't do it right."
    erb :'auth/_signup'
  end
end

get '/logout' do
  session[:id] = nil
  redirect '/'
end