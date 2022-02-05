require "application_system_test_case"
require 'minitest/mock'

class PostsTest < ApplicationSystemTestCase
  include ActiveJob::TestHelper

  DUMMY_JSON = {
    'responses': [
      { 'utterance': 'ダミーレスポンス' }
    ]
  }.to_json

  test 'ユーザーは新しいコメントを投稿すると、新たに画面上に表示される' do
    visit posts_url

    assert_selector :id, "post_#{posts(:one).id}", visible: false
    assert_selector :id, "post_#{posts(:two).id}", visible: false

    click_button 'つぶやく'

    assert_text 'メッセージを入力してください'

    fill_in 'post_message', with: '好きな食べ物は何ですか？'

    # ジョブが１つ登録されたことを確認(assertを同じブロックに入れないとジョブ登録の前に判定してしまいエラーになる)
    assert_enqueued_jobs 1 do
      click_button 'つぶやく'

      assert_text 'うーんとね...'
      assert_no_text 'メッセージを入力してください'
    end

    # APIレスポンスのモック作成
    res = Minitest::Mock.new.expect(:body, DUMMY_JSON)
    # APIリクエストメソッドをスタブ化し、上のモックを返すよう変更する
    ChaplusApiJob.stub_any_instance :send_chaplus_api, res do
      perform_enqueued_jobs
    end

    assert_no_text 'うーんとね...'
    assert_text '好きな食べ物は何ですか？'
    assert_text 'ダミーレスポンス'
    # ジョブが実行されたため、エンキューにジョブが無いことを確認する
    assert_no_enqueued_jobs
    # ジョブが一つ実行されたことを確認する
    assert_performed_jobs 1
  end

  test 'ユーザーは新しいコメントを投稿すると、別のユーザーの画面上に表示される' do
    visit posts_url

    assert_no_text '好きな食べ物は何ですか？'
    assert_no_text 'ダミーレスポンス'

    within_session :another_user do
      visit posts_url

      fill_in 'post_message', with: '好きな食べ物は何ですか？'

      assert_enqueued_jobs 1 do
        click_button 'つぶやく'
        assert_text 'うーんとね...'
      end

      res = Minitest::Mock.new.expect(:body, DUMMY_JSON)
      ChaplusApiJob.stub_any_instance(:send_chaplus_api, res) do
        perform_enqueued_jobs
      end

      assert_no_text 'うーんとね...'
      assert_text '好きな食べ物は何ですか？'
      assert_text 'ダミーレスポンス'
      assert_no_enqueued_jobs
      assert_performed_jobs 1
    end

    assert_text '好きな食べ物は何ですか？'
    assert_text 'ダミーレスポンス'
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
