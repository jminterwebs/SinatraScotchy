class ScotchController < ApplicationController

  get '/scotch' do
    @scotches = Scotch.all
    erb :'scotch/index'
  end

  get '/scotch/new' do
    erb :'scotch/new'
  end

  post '/new' do
    if params[:name] == "" || params[:age] == "" || params[:abv] == ""
      redirect to "/signup"
    else
      Scotch.create(name: params[:name], age: params[:age], abv: params[:abv], region: params[:region])
      redirect to '/'
    end
  end


 get '/scotch/:slug' do
    @scotch = Scotch.find_by_slug(params[:slug])
    erb :'scotch/show'
  end

  delete '/scotch/:slug' do
    @scotch = Scotch.find_by_slug(params[:slug])
    @scotch.delete
    redirect '/'
  end


end
