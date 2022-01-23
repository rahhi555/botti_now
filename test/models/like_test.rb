require "test_helper"

class LikeTest < ActiveSupport::TestCase
  context 'userがbelong_toとして関連付けられていること' do
    should belong_to(:user).without_validating_presence.class_name('User')
  end

  context 'postがbelong_toとして関連付けられていること' do
    should belong_to(:post).without_validating_presence.class_name('Post')
  end

  test 'コメントの投稿者は自分のコメントにいいねを出来ないこと' do
    user = users(:one)
    post_id = user.posts.first.id
    like = user.likes.build(post_id:)
    like.valid?
    assert_includes like.errors.full_messages, 'コメントの投稿者本人は、自分の投稿に対していいねを出来ません'
  end

  test 'ユーザーは同じコメントに複数回いいね出来ないこと' do
    user = likes(:one).user
    post_id = likes(:one).post.id
    like = user.likes.build(post_id:)
    like.valid?
    assert_includes like.errors.full_messages, 'ユーザーは同じコメントにいいね出来ません'
  end

  test 'コメントの投稿者とは別のユーザーならば、コメントにいいねを出来ること' do
    user = User.create!
    post_id = posts(:one).id
    like = user.likes.build(post_id:)
    assert like.valid?
  end
end
