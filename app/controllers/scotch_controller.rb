class ScotchController < ApplicationController

  get '/scotch' do
    @scotches = Scotch.all
    erb :'scotch/index'
  end

  get '/scotch/new' do
    erb :'scotch/new'
  end

  post '/new' do
    @user = User.find_by_id(current_user.id)
    if params[:name] == "" || params[:age] == "" || params[:abv] == ""
      redirect to "/signup"
    else
      @scotch  = Scotch.create(name: params[:name], age: params[:age], abv: params[:abv], region: params[:region])
      @scotch.users << @user
      redirect to '/'
    end
  end


 get '/scotch/:slug' do
    @scotch = Scotch.find_by_slug(params[:slug])
    erb :'scotch/show'
  end

  post '/scotch/:slug/add' do
    @scotch = Scotch.find_by_slug(params[:slug])
    @user = User.find_by_id(current_user.id)

    @scotch.users << @user

    @scotch.save


    redirect '/'
  end


end
