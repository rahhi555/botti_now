# frozen_string_literal: true

class PostsControllerTest < ActionDispatch::IntegrationTest
  include ApplicationHelper
  include ActiveJob::TestHelper

  test 'indexでは最大10個の投稿が返ってくること' do
    get posts_url
    assert_response :success
    assert_operator Post.count, :>, Kaminari.config.default_per_page
    assert_equal Kaminari.config.default_per_page, controller.view_assigns['posts'].length
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

  test 'indexアクセス前にcreateを実行しても、弾かれること' do
    assert_no_difference 'Post.count' do
      post posts_path, params: { post: { message: 'new post' } }
    end
    assert_redirected_to root_path
  end

  test 'indexアクセス後なら、createでpostの登録ができること' do
    get posts_path
    assert_difference 'Post.count' do
      post posts_path, params: { post: { message: 'new post' } }
    end
    assert_response :success
  end

  test 'createアクションが成功した場合、chaplus_api_jobがエンキューされること' do
    get posts_path
    assert_enqueued_with(job: ChaplusApiJob) do
      post posts_path, params: { post: { message: 'new post' } }
    end
  end

  test 'createでpostの登録に失敗した場合、unprocessable_entityが返ってくること' do
    get posts_path
    assert_no_difference 'Post.count' do
      post posts_path, params: { post: { message: '' } }
    end
    assert_response :unprocessable_entity
  end

  test 'createでpostの登録に失敗した場合、chaplus_api_jobがエンキューされないこと' do
    get posts_path
    assert_no_enqueued_jobs do
      post posts_path, params: { post: { message: '' } }
    end
  end

  test 'loadアクションが正常に動作すること' do
    get posts_url
    assert_operator Post.count, :>, Kaminari.config.default_per_page
    post posts_load_path, params: { page: 2 }, headers: { Accept: 'text/vnd.turbo-stream.html' }
    assert_response :success
    assert_equal Post.count - Kaminari.config.default_per_page, controller.view_assigns['posts'].length
  end
end
