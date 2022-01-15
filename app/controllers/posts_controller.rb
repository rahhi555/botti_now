# frozen_string_literal: true

class PostsController < ApplicationController
  def index
    @posts = Post.all
  end

  def create
    if Post.create(post_params.merge(user_id: User.first.id))
      redirect_to action: :index
    else
      render :index, status: :unprocessable_entity
    end
  end

  def delete; end

  def update; end

  private

  def post_params
    params.require(:post).permit(:message, :like, :user_id)
  end
end
