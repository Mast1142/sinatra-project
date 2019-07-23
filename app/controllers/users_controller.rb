class UsersController < ApplicationController
  get "/signup" do
    if !logged_in?
      erb :"users/signup"
    else
      redirect "/tasks"
    end
  end

  post "/signup" do
    if params[:username] != "" && params[:email] != "" && params[:password] != ""
      validates_format_of :email,:with => /\A[^@\s]+@([^@\s]+\.)+[^@\s]+\z/
      @user = User.new(params)
      @user.save
      session[:user_id] = @user.id
      redirect "/tasks"
    else
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
