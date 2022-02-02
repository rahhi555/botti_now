# frozen_string_literal: true

class PostsController < ApplicationController
  skip_before_action :have_current_user, only: :index

  def index
    unless current_user
      @current_user = User.create!
      session[:user_id] = @current_user.id
    end
    @posts = Post.all.includes(:likes)
  end

  def create
    post = current_user.posts.build(post_params)

    if post.save
      post.broadcast_append_to 'tweet_page'
      render turbo_stream:
               turbo_stream.replace('bot_message',
                                    partial: 'chaplus_api/message',
                                    locals: { message: 'うーんとね...' })
    else
      render turbo_stream:
               turbo_stream.replace('error_messages',
                                    partial: 'shared/error_messages',
                                    locals: { object: post }),
             status: :unprocessable_entity
    end
  end

  def delete; end

  def update; end

  private

  def post_params
    params.require(:post).permit(:message, :user_id)
  end
end
