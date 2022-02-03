# frozen_string_literal: true

module PostDecorator
  include ApplicationHelper

  # ツイートのふわっと浮き上がるアニメーションスタイルを返す。
  # その際アニメーションの全体の時間(duration),アニメーションが始まる時間(delay)及び画面の配置(left)は初期値はランダムで決まる。
  # ただしdelayに関しては作成直後のものはすぐ表示される。
  def bubble_style
    duration = rand(10..20)
    left = rand(20..70)
    # delay = (Time.current - created_at) < 10 ? 0 : rand(1..60)
    delay = (Time.current - created_at) < 10 ? 0 : rand(1..10)
    "animation: tweet-bubble #{duration}s #{delay}s; left: #{left}vw;"
  end

  # @return Boolean
  # 対象の投稿を現在のユーザーがいいね済みかどうかを判定する。
  # ブロードキャストのタイミングによってはcurrent_user
  def current_user_liked?
    likes.pluck(:user_id).include?(current_user&.id)
  end
end
