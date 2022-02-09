class RankingController < ApplicationController
  def index
    @posts = Post.desc_likes_count.includes(:user).page(1)
  end

  def load
    @posts = Post.desc_likes_count.includes(:user).page(params[:page])
    turbo_stream
  end
end
