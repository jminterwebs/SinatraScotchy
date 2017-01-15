require 'pry'

class CommentController < ApplicationController

  get '/scotch/:slug/comments' do
    @scotch = Scotch.find_by_slug(params[:slug])

    redirect to  "/scotch/#{@scotch.slug}" unless !@scotch.comments.find_by(user_id: current_user.id)


    # binding.pry
    erb :'/comments/new'
  end

  post '/scotch/:slug/comments' do
    @scotch = Scotch.find_by_slug(params[:slug])
    Comment.create(content: params[:comment], scotch_id: @scotch.id, user_id: current_user.id, commenter: current_user.username)

    redirect to  "/scotch/#{@scotch.slug}"
  end

end
