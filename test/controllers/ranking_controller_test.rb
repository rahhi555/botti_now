# frozen_string_literal: true

class RankingControllerTest < ActionDispatch::IntegrationTest
  include ApplicationHelper

  KAMINARI_PAR_PAGE = 20

  def setup
    get posts_url
  end

  test 'indexアクセス時は20件の投稿を返すこと' do
    get posts_url
    create_list_post(10)
    assert_operator Post.count, :>, KAMINARI_PAR_PAGE
    get ranking_index_path
    assert_response :success
    assert_equal KAMINARI_PAR_PAGE, controller.view_assigns['posts'].length
  end

  test 'showアクションが正常に動作すること' do
    get ranking_path(posts(:one))
    assert_response :success
  end

  test 'editアクションが正常に動作すること' do
    get edit_ranking_path(posts(:one))
    assert_response :success
  end

  test '正常な値の場合、updateが成功すること' do
    post = current_user.posts.create!(message: 'old_message')
    NEW_MESSAGE = 'new_message'
    patch ranking_path(post), params: { post: { message: NEW_MESSAGE } }
    assert_response :success
    assert_equal post.reload.message, NEW_MESSAGE
  end

  test '異常値の場合、updateに失敗すること' do
    post = current_user.posts.create!(message: 'old_message')
    patch ranking_path(post), params: { post: { message: '' } }
    assert_response :unprocessable_entity
  end

  test 'destroyアクションが正常に動作すること' do
    post = current_user.posts.create!(message: 'message')
    assert_difference 'Post.count', -1 do
      delete ranking_path(post)
    end
    assert_response :success
  end

  test 'loadアクションが正常に動作すること' do
    get ranking_index_path
    create_list_post(10)
    assert_operator Post.count, :>, KAMINARI_PAR_PAGE
    post ranking_load_path, params: { page: 2 }, headers: { Accept: 'text/vnd.turbo-stream.html' }
    assert_response :success
    assert_equal Post.count - KAMINARI_PAR_PAGE, controller.view_assigns['posts'].length
  end
end
