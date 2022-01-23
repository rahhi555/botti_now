class LikesController < ApplicationController
  def create
    post = Post.find(params[:post_id])
    post.likes.create!(user_id: current_user.id)
    render turbo_stream:
             turbo_stream.replace("like_post_#{post.id}", "いいね！#{post.likes.count}")
  end

  def delete
  end
end
