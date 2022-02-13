# frozen_string_literal: true

module PostDecorator
  include ApplicationHelper

  # @param [Integer] post_counter
  # @return [String]
  # ツイートのふわっと浮き上がるアニメーションスタイルを返す。
  # その際アニメーションの全体の時間(duration)及び画面の配置(left)は初期値はランダムで決まる。
  # ただしdelayに関しては作成直後のものはすぐ表示され、それ以外は順番に表示される。
  def bubble_style(post_counter)
    duration = rand(13..18)
    left = rand(0..70)
    delay = (Time.current - created_at) < 10 ? 0 : (post_counter + 1) * 3 + rand(0.1..2.0)
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

  # @return [Boolean]
  # 投稿が現在から1分以内かどうかを返す
  def now?
    created_at.between?(Time.current.ago(1.minutes), Time.current)
  end
end
