class CommentController < ApplicationController

  get '/scotch/:slug/comments' do
    @scotch = Scotch.find_by_slug(params[:slug])
    erb :'/scotch/edit'
  end

  post '/scotch/:slug/comments' do
    @scotch = Scotch.find_by_slug(params[:slug])
    Comment.create(content: params[:comment], scotch_id: @scotch.id, user_id: current_user.id)
  end

end
