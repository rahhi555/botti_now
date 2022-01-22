require "application_system_test_case"

class PostsTest < ApplicationSystemTestCase
  test 'ユーザーは新しいコメントを投稿すると、新たに画面上に表示される' do
    visit posts_url

    assert_selector :id, "post_#{posts(:one).id}", visible: false
    assert_selector :id, "post_#{posts(:two).id}", visible: false

    click_button 'つぶやく'

    assert_text 'メッセージを入力してください'

    fill_in 'post_message', with: 'テストメッセージ'

    click_button 'つぶやく'

    assert_text 'テストメッセージ'
    assert_no_text 'メッセージを入力してください'
  end

  test 'ユーザーは新しいコメントを投稿すると、別のユーザーの画面上に表示される' do
    visit posts_url

    assert_no_text 'テストメッセージ'

    within_session :another_user do
      visit posts_url

      fill_in 'post_message', with: 'テストメッセージ'

      click_button 'つぶやく'

      assert_text 'テストメッセージ'
    end

    assert_text 'テストメッセージ'

    close_session :another_user
  end

  # 新たにセッションを作成し、渡されたブロックの処理を行った後、元のセッションに戻る
  # https://techracho.bpsinc.jp/hachi8833/2018_02_27/52183を参考に実装
  def within_session(name)
    old_session_name = Capybara.session_name
    Capybara.session_name = name.to_sym

    yield

    Capybara.session_name = old_session_name
  end

  def close_session(name, original_session = :default)
    Capybara.session_name = name.to_sym

    page.driver.quit

    Capybara.session_name = original_session
  end
end
