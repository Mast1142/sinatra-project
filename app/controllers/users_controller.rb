class UsersController < ApplicationController
  get "/signup" do
    if !logged_in?
      erb :"users/signup"
    else
      redirect "/tasks"
    end
  end

  post "/signup" do
    VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
    if params[:username] != "" && params[:email] != "" && !!(params[:email]=~ VALID_EMAIL_REGEX) && params[:password] != ""
      @user = User.new(params)
      @user.save
      session[:user_id] = @user.id
      redirect "/tasks"
    else
      @error = "Username & Password cannot be blank. A valid email is required for signup."
      redirect "/signup"
    end
  end

  get '/login' do
    if !logged_in?
      erb :"/users/login"
    else
      redirect "/tasks"
    end
  end

  post '/login' do
    @user = User.find_by(username: params[:username])
    #binding.pry
    if @user && @user.authenticate(params[:password])
      session[:user_id] = @user.id
      redirect "/tasks"
    else
      redirect "/login"
    end
  end

  get '/logout' do
    if !logged_in?
      redirect "/"
    else
      session.destroy
    end
    redirect "/login"
  end

end
