require 'rack-flash'


class UsersController < ApplicationController
  use Rack::Flash
  get '/user/logout' do
      if logged_in?
        session.clear
      end
      redirect '/'
  end

  get '/user/signup' do
    if logged_in?
      redirect to "/user/#{current_user.slug}"
      # redirect '/scotch'
    end
    erb :'user/new'
  end

  post '/signup' do
    if params[:username] == "" || params[:password] == "" || params[:email] == ""
      redirect to "/signup"
    else
      User.create(username: params[:username], email: params[:email], password: params[:password])
      @user = User.find_by(username: params[:username])
      session[:user_id] = @user.id
      redirect to '/'
    end
  end

  get '/user/login' do
    if logged_in?
      redirect to "/user/#{current_user.slug}"
    end
    erb :'user/index'
  end

  get '/user/:slug' do
    @user = User.find_by_slug(params[:slug])
        erb :'user/show'
  end

  post '/user/login' do
    @user = User.find_by(username: params[:username])
    if @user && @user.authenticate(params[:password])
      session[:user_id] = @user

      redirect to "/user/#{@user.slug}"
    else
      redirect '/login'
    end
  end

  patch '/user/remove/:slug/:scotch_slug' do
    @scotch = Scotch.find_by_slug(params[:scotch_slug])
    @user = User.find_by_slug(params[:slug])

    if current_user.id == @user.id
      @user.scotches.delete(@scotch)
    end
    flash[:message] = "Please remove scotches from your profile only"
    redirect "/user/#{current_user.slug}"

  end


  # delete '/user/:slug' do
  #   @user = User.find_by_slug(params[:slug])
  #
  #   @user.delete unless current_user.id != @user.id
  #
  #   redirect '/'
  # end



end
