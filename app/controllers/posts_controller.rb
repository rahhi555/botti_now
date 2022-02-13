# frozen_string_literal: true

class PostsController < ApplicationController
  skip_before_action :have_current_user, only: :index

  def index
    unless current_user
      @current_user = User.create!
      session[:user_id] = @current_user.id
    end

    # Turbo::StreamsChannel.broadcast_replace_to('tweet_page',
    #                                            target: 'login_announce',
    #                                            partial: 'posts/login_announce',
    #                                            locals: { user: current_user, me: false })
    @posts = Post.desc_likes_count.includes(:likes).page(1)
  end

  def create
    post = current_user.posts.build(post_params)

    if post.save
      ChaplusApiJob.perform_later(current_user, post)
      render turbo_stream:
               turbo_stream.replace('bot_message',
                                    partial: 'chaplus_api/message',
                                    locals: { bot_message: t("bot.loading") })
    else
      render turbo_stream:
               turbo_stream_error_messages(post),
             status: :unprocessable_entity
    end
  end

  def load
    @posts = Post.desc_likes_count.includes(:likes).page(params[:page])
    turbo_stream
  end

  private

  def post_params
    params.require(:post).permit(:message, :user_id, :bot_message)
  end
end
