require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "password_security"
  end

  get "/" do
    @users = User.all
    @scotches = Scotch.all
    erb :index
  end


  helpers do
      def logged_in?
        !!current_user
      end

      def current_user
        # memoization
        @current_user ||= User.find(session[:user_id]) if session[:user_id] != nil
      end

  end
end
