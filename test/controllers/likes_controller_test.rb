# frozen_string_literal: true

require 'test_helper'
require 'minitest/mock'

class LikesControllerTest < ActionDispatch::IntegrationTest
  test 'createアクションを実行するといいねが追加されること' do
    get posts_path
    assert_difference 'Like.count' do
      post post_likes_path(posts(:one))
    end
    assert_response :success
  end
end
