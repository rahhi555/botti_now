# frozen_string_literal: true

class PostsController < ApplicationController
  def index
    @posts = Post.all
  end

  def create
    @post = Post.new(post_params.merge(user_id: User.first.id))

    @post.save
  end

  def delete; end

  def update; end

  private

  def post_params
    params.require(:post).permit(:message, :like, :user_id)
  end
end
