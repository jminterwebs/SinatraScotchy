class ScotchController < ApplicationController

  get '/scotch' do

    erb :'/scotch/show'
  end

  get '/scotch/new' do

    erb :'scotch/new'
  end

end
