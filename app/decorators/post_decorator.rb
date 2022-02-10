# frozen_string_literal: true

module PostDecorator
  include ApplicationHelper

  # @return [String]
  # ツイートのふわっと浮き上がるアニメーションスタイルを返す。
  # その際アニメーションの全体の時間(duration),アニメーションが始まる時間(delay)及び画面の配置(left)は初期値はランダムで決まる。
  # ただしdelayに関しては作成直後のものはすぐ表示される。
  def bubble_style
    # duration = rand(15..25)
    duration = 5
    left = rand(0..70)
    # delay = (Time.current - created_at) < 10 ? 0 : rand(1..40)
    delay = (Time.current - created_at) < 10 ? 0 : rand(1..3)
    "animation: tweet-bubble #{duration}s #{delay}s; left: #{left}vw;"
  end

  # @param [User] user
  # @return [Boolean]
  # 対象の投稿を現在のユーザーがいいね済みかどうかを判定する。
  def current_user_liked?(user)
    likes.pluck(:user_id).include?(user&.id)
  end

  # @param [User] user
  # @return [Boolean]
  def mine?(user)
    user.id == self.user.id
  end
end
