class RankingController < ApplicationController
  def index
    @posts = Post.all.includes(:user, :likes)
  end
end
