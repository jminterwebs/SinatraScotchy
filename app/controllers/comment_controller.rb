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
    if logged_in?
      @scotch = Scotch.find_by_slug(params[:slug])
      @scotch.comments.build(content: params[:comment], user_id: current_user.id)
      if @scotch.save
        flash[:notice] = "Thanks for commenting!"
      else
        flash[:notice] = "Your comment is lost in space and time!"
      end
      redirect to  "/scotches/#{@scotch.slug}"
    else
      redirect to '/'
    end
  end

end
