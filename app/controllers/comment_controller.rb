require 'pry'

class CommentController < ApplicationController

  get '/scotches/:slug/comments' do
    if logged_in?
      @scotch = Scotch.find_by_slug(params[:slug])

      redirect to  "/scotches/#{@scotch.slug}" unless !@scotch.comments.find_by(user_id: current_user.id)
      erb :'/comments/new'
    else
      redirect '/'
    end
  end

  post '/scotches/:slug/comments' do
    @scotch = Scotch.find_by_slug(params[:slug])
    Comment.create(content: params[:comment], scotch_id: @scotch.id, user_id: current_user.id)

    redirect to  "/scotches/#{@scotch.slug}"
  end

end
