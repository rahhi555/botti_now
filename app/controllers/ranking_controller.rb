class RankingController < ApplicationController
  def index
    @posts = Post.desc_likes_count.includes(:user).page(1).per(20)
  end

  def load
    @posts = Post.desc_likes_count.includes(:user).page(params[:page]).per(20)
    turbo_stream
  end
end
