# frozen_string_literal: true

class LikesController < ApplicationController
  def create
    @post = Post.find(params[:post_id])
    @post.likes.create!(user_id: current_user.id)
    turbo_stream
  end
end
