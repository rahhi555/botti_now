require "test_helper"

class PostsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    assert_generates '/', controller: 'home', action: 'index'
    get posts_url
    assert_response :success
  end

  # test "should get create" do
  #   get posts_create_url
  #   assert_response :success
  # end
  #
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
