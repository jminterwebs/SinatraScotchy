require 'rack-flash'
require 'pry'

class ScotchController < ApplicationController
  use Rack::Flash

  get '/scotches' do
    @scotches = Scotch.all
    erb :'scotch/index'
  end

  get '/scotches/new' do
    erb :'scotch/new'
  end
# fix validations
# secure logged_ins
# fix comments delete rotues
  post '/scotches' do
    @scotch = Scotch.new(name: params[:name], age: params[:age], abv: params[:abv], region: params[:region])

    if logged_in?
      if @scotch.save
        current_user.scotches << @scotch
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
     @scotch = Scotch.find_by_slug(params[:slug])
    erb :'scotch/show'
  end

  post '/scotches/:slug/add' do
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
