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
    post = current_user.posts.find(params[:id])
    if post.update(post_params)
      flash.now[:notice] = t("default.message.updated", item: Post.model_name.human)
      render turbo_stream: [
        turbo_stream.replace(helpers.dom_id(post, :message), partial: 'ranking/post_message', locals: { post: }),
        turbo_stream_flash
      ]
    else
      flash.now[:alert] = t("default.message.not_updated", item: Post.model_name.human)
      render turbo_stream: [turbo_stream_flash, turbo_stream_error_messages(post)]
    end
  end

  def destroy
    post = current_user.posts.find(params[:id])
    post.destroy!
    flash.now[:notice] = t("default.message.destroyed", item: Post.model_name.human)
    render turbo_stream: [turbo_stream.remove(post), turbo_stream_flash]
  end

  def load
    @posts = Post.desc_likes_count.includes(:user).page(params[:page]).per(20)
    turbo_stream
  end

  private

  def post_params
    params.require(:post).permit(:message)
  end
end
