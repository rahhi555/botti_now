# frozen_string_literal: true

require 'test_helper'

class PostsControllerTest < ActionDispatch::IntegrationTest
  test 'indexではpostの一覧が反ること' do
    assert_generates '/', controller: 'home', action: 'index'
    get posts_url
    assert_response :success
    assert_equal 2, @controller.view_assigns['posts'].length
  end

  test 'createではpostの登録ができること' do
    assert_difference 'Post.count' do
      post user_posts_path(users(:one).id), params: { post: { message: 'new post' } }
    end
    assert_response :success
  end

  # test "should get delete" do
  #   get posts_delete_url
  #   assert_response :success
  # end
  #
  # test "should get update" do
  #   get posts_update_url
  #   assert_response :success
  # end
end
