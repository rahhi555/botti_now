require "test_helper"
require 'minitest/mock'

class ChaplusApiJobTest < ActiveJob::TestCase
  include ActionCable::TestHelper

  DUMMY_JSON = {
    'responses': [
      { 'utterance': 'ダミーテキスト' }
    ]
  }.to_json

  test 'post.bot_messageにボットのテキストが挿入され、tweet_pageとuserにブロードキャストされること' do
    res = Minitest::Mock.new.expect(:body, DUMMY_JSON)

    ChaplusApiJob.stub_any_instance :send_chaplus_api, res do
      ChaplusApiJob.perform_now(users(:one), posts(:one))
    end

    assert_broadcasts 'tweet_page', 1
    assert_broadcasts users(:one).to_gid_param, 1
    assert_equal 'ダミーテキスト', posts(:one).bot_message
  end

  test 'エラーが発生した場合は、postが削除されuserにブロードキャストされること' do
    res = Minitest::Mock.new.expect(:body, '文字列リテラルなので、JSON.parseでエラーが起きます')

    ChaplusApiJob.stub_any_instance :send_chaplus_api, res do
      ChaplusApiJob.perform_now(users(:one), posts(:one))
    end

    assert_no_broadcasts 'tweet_page'
    assert_broadcasts users(:one).to_gid_param, 1
    assert_raises(ActiveRecord::RecordNotFound) { posts(:one).reload }
  end
end
