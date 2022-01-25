# frozen_string_literal: true

require 'debug'

class LikesController < ApplicationController
  def create
    post = Post.find(params[:post_id])
    post.likes.create!(user_id: current_user.id)
    render turbo_stream:
             turbo_stream.replace(view_context.dom_id(post, :like), partial: 'likes/like_button', locals: { post: })
  end

  def delete; end
end
