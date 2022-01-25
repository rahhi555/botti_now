# frozen_string_literal: true

require 'test_helper'

class LikesControllerTest < ActionDispatch::IntegrationTest
  test 'indexアクセス後にcreateアクションを実行すると、いいねが追加されること' do
    get posts_path
    assert_difference 'Like.count' do
      post post_likes_path(posts(:one))
    end
    assert_response :success
  end

  test 'indexアクセス前にcreateアクションを実行すると、弾かれること' do
    assert_no_difference 'Like.count' do
      post post_likes_path(posts(:one))
    end
    assert_redirected_to root_path
  end
end
