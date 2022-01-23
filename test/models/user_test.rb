# frozen_string_literal: true

require 'test_helper'

class UserTest < ActiveSupport::TestCase
  context 'postsが関連付けられていること' do
    should have_many(:posts).class_name('Post')
  end

  context 'likesが関連付けられていること' do
    should have_many(:likes).class_name('Like')
  end

  context 'nameに空文字は許容しないこと' do
    should validate_presence_of(:name)
  end

  test 'user作成時にデフォルトでnameが入ること' do
    user = User.create
    assert user.valid?
    assert user.name
  end

  test 'userを削除した場合、postとlikeはそのまま残ること' do
    user = User.create!
    post = user.posts.create!(message: 'new post')
    like = user.likes.create!(post_id: posts(:one).id)
    user.destroy!
    assert_nil post.reload.user
    assert_nil like.reload.user
  end
end
