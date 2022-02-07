# frozen_string_literal: true

class PostsController < ApplicationController
  skip_before_action :have_current_user, only: :index

  def index
    unless current_user
      @current_user = User.create!
      session[:user_id] = @current_user.id
    end

    @posts = Post.page(1).includes(:likes)
  end

  def load
    @posts = Post.page(params[:page]).includes(:likes)
    turbo_stream
  end

  def create
    post = current_user.posts.build(post_params)

    if post.save
      ChaplusApiJob.perform_later(current_user, post)
      render turbo_stream:
               turbo_stream.replace('bot_message',
                                    partial: 'chaplus_api/message',
                                    locals: { bot_message: 'うーんとね...' })
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
