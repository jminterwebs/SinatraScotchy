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

    @user = User.new(username: params[:username], email: params[:email], password: params[:password])
    if @user.save
        session[:user_id] = @user.id
        redirect to "/user/#{current_user.slug}"
    else
      flash[:message] = @user.errors.full_messages
      redirect to "/user/signup"
    end
  end

  get '/user/login' do
    if logged_in?
      redirect to "/user/#{current_user.slug}"
    end
    erb :'user/index'
  end

  get '/user/:slug' do
    if logged_in?
      @user = User.find_by_slug(params[:slug])
      erb :'user/show'
    else
      redirect '/'

      
    end
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
    if logged_in?
      if current_user.id == @user.id
        @user.destroy
        session.clear
        redirect '/'
      else
        flash[:message] = "Please do not try to delete other profiles"
        redirect "/user/#{current_user.slug}"
      end
    else
      flash[:message] = "You are not logged in. Please log in or create an account!"
      redirect '/'
    end
  end
end
