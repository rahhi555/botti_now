# frozen_string_literal: true

class PostsController < ApplicationController
  def index
    set_or_create_user
    @posts = Post.all
    @post = Post.new
  end

  def create
    user = User.find(params[:user_id])
    @post = user.posts.build(post_params)
    if @post.save
      render turbo_stream: [
        turbo_stream.append('tweet_page'),
        turbo_stream.replace('tweet_error', partial: 'shared/error_messages', locals: { object: @post })
      ]
    else
      render turbo_stream:
        turbo_stream.replace('tweet_error', partial: 'shared/error_messages', locals: { object: @post }),
             status: :unprocessable_entity
    end
  end

  def delete; end

  def update; end

  private

  def post_params
    params.require(:post).permit(:message, :like, :user_id)
  end

  def set_or_create_user
    @user = User.find_or_create_by!(id: session[:user_id])
    session[:user_id] = @user.id
    @user
  end
end
