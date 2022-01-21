require "application_system_test_case"

class PostsTest < ApplicationSystemTestCase
  test 'ユーザーは新しいコメントを投稿すると、新たに画面上に追加される' do
    visit posts_url

    assert_selector :id, "post_#{posts(:one).id}", visible: false
    assert_selector :id, "post_#{posts(:two).id}", visible: false

    fill_in 'post_message', with: 'テストメッセージ'

    click_button 'つぶやく'

    assert_text :visible, 'テストメッセージ'
  end
end
