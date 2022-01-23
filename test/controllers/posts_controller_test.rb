# frozen_string_literal: true

class PostsControllerTest < ActionDispatch::IntegrationTest
  include ApplicationHelper

  test 'indexではpostの一覧が反ること' do
    get posts_url
    assert_response :success
    assert_equal 2, controller.view_assigns['posts'].length
  end

  test 'indexにアクセスすると新たにユーザーが作成され、再びアクセスした場合はユーザーが作成されない' do
    assert_changes -> { User.count } do
      get posts_url
    end
    assert_equal session[:user_id], current_user.id

    assert_no_changes -> { User.count } do
      get posts_url
    end
  end

  test 'createではpostの登録ができること' do
    assert_difference 'Post.count' do
      post user_posts_path(users(:one).id), params: { post: { message: 'new post' } }
    end
    assert_response :success
  end

  test 'createでpostの登録に失敗した場合、unprocessable_entityが返ってくること' do
    assert_no_difference 'Post.count' do
      post user_posts_path(users(:one).id), params: { post: { message: '' } }
    end
    assert_response :unprocessable_entity
  end
  #
  # test "should get update" do
  #   get posts_update_url
  #   assert_response :success
  # end
end
