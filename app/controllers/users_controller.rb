require 'rack-flash'
require 'pry'


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
    else
     erb :'user/new'
    end
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
      redirect '/user/login'
    end
  end

  patch '/user/remove/:slug/:scotch_slug' do
    @scotch = Scotch.find_by_slug(params[:scotch_slug])
    @user = User.find_by_slug(params[:slug])

    if current_user.id == @user.id
      @user.scotches.delete(@scotch)
    else
      flash[:message] = "Please remove scotches from your profile only"
    end
    redirect "/user/#{current_user.slug}"

  end


  delete '/user/delete/:slug' do
  @user = User.find_by_slug(params[:slug])

    if current_user.id == @user.id
      @user.delete
      session.clear
      redirect '/'
    else
      flash[:message] = "Please do not try to delete other profiles"
      redirect "/user/#{current_user.slug}"
    end

  end



end
