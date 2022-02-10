class RankingController < ApplicationController
  def index
    @posts = Post.desc_likes_count.includes(:user).page(1).per(20)
  end

  def show
    post = Post.find(params[:id])
    render partial: 'ranking/post_message', locals: { post: }
  end

  def edit
    post = Post.find(params[:id])
    render partial: 'ranking/edit', locals: { post: }
  end

  def update
    p params
    post = current_user.posts.find(params[:id])
    if post.update(post_params)
      render partial: 'ranking/post_message', locals: { post: }
    else
      render partial: 'ranking/edit', locals: { post: }, status: :unprocessable_entity
    end
  end

  def delete; end

  def load
    @posts = Post.desc_likes_count.includes(:user).page(params[:page]).per(20)
    turbo_stream
  end

  private

  def post_params
    params.require(:post).permit(:message)
  end
end
