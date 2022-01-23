# frozen_string_literal: true

class PostsController < ApplicationController
  def index
    set_or_create_user
    @posts = Post.all.includes(:likes, :user)
    @post = Post.new
  end

  def create
    user = User.find(params[:user_id])
    @post = user.posts.build(post_params)

    if @post.save
      head :ok
    else
      render turbo_stream:
               turbo_stream.replace('error_messages', partial: 'shared/error_messages', locals: { object: @post }),
             status: :unprocessable_entity
    end
  end

  def delete; end

  def update; end

  private

  def post_params
    params.require(:post).permit(:message, :user_id)
  end

  def set_or_create_user
    unless current_user
      @current_user = User.create!
      session[:user_id] = @current_user.id
    end
  end
end
