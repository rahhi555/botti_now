require "application_system_test_case"

class LikesTest < ApplicationSystemTestCase
  test 'いいねマークをクリックすると、いいねされること' do
    # 要素が複数あると被ってクリックできなくなるので片方削除
    posts(:two).destroy

    visit posts_url

    like_partial = find "#like_post_#{posts(:one).id}", visible: false

    like_partial.has_css?('.bg-green-600')
    like_partial.has_text?("いいね！#{posts(:one).likes.length}")

    assert_difference 'Like.count' do
      like_partial.find_button.click
      like_partial.has_css?('.bg-pink-500')
      like_partial.has_text?("いいね！#{posts(:one).reload.likes.length}")
    end
  end
end
