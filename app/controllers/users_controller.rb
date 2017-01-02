class UsersController < ApplicationController

  get '/signup' do
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

  # delete '/:slug' do
  #   @user = User.find_by_slug(params[:slug])
  #
  #   @user.delete unless current_user.id != @user.id
  #
  #   redirect '/'
  # end

end
