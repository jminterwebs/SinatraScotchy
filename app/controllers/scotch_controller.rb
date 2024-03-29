require 'rack-flash'
require 'pry'

class ScotchController < ApplicationController
  use Rack::Flash

  get '/scotches' do
    if logged_in?
      @scotches = Scotch.all
      erb :'scotch/index'
    else
      redirect to '/'
    end
  end

  get '/scotches/new' do
    erb :'scotch/new'
  end

  post '/scotches' do
    if logged_in?
      @scotch = current_user.scotches.build(name: params[:name], age: params[:age], abv: params[:abv], region: params[:region])


      if @scotch.save
        redirect to "/user/#{current_user.slug}"
      else
        flash[:message] = "#{@scotch.errors.full_messages} Scotch was already picked added by other users"
        redirect to "/scotches"
      end
    else
      redirect to '/signup'
    end
  end


  get '/scotches/:slug' do
    if_logged_in_go_home
    @scotch = Scotch.find_by_slug(params[:slug])
    erb :'scotch/show'
  end

  post '/scotches/:slug/add' do
    if_not_logged_in_go_home
    @scotch = Scotch.find_by_slug(params[:slug])
    @user = User.find_by_id(current_user.id)

    if @user.scotches.include?(@scotch)
      flash[:message] = "Scotch already added!"
      redirect to "/user/#{@user.slug}"

    else
      @scotch.users << @user
    end
    @scotch.save
    redirect to "/user/#{@user.slug}"
  end






end
