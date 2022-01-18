# frozen_string_literal: true

class PostsController < ApplicationController
  def index
    @posts = Post.all
  end

  def create
    pp "params: #{post_params}"
    @post = Post.create(post_params.merge(user_id: User.first.id))
    pp "error msg: #{@post.errors.full_messages}"
  end

  def delete; end

  def update; end

  private

  def post_params
    params.require(:post).permit(:message, :like, :user_id)
  end
end
