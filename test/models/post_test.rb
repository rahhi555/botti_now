# frozen_string_literal: true

require 'test_helper'

class PostTest < ActiveSupport::TestCase
  context 'userがbelong_toとして関連付けられていること' do
    should belong_to(:user).class_name('User')
  end

  context 'likeがhas_manyとして関連付けられていること' do
    should have_many(:likes).class_name('Like')
  end

  context 'messageは255文字までであること' do
    should validate_length_of(:message)
  end

  context '空文字は許容しないこと' do
    should validate_presence_of(:message)
  end

  test 'ユーザーを紐付けないで投稿を作成することは出来ないこと' do
    post = Post.new(message: 'new message')
    post.valid?
    assert_includes post.errors.full_messages, 'ユーザーを入力してください'
  end
end
