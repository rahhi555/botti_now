# frozen_string_literal: true

require 'test_helper'

class UserTest < ActiveSupport::TestCase
  context 'postsが関連付けられていること' do
    should have_many(:posts).class_name('Post')
  end

  context 'nameに空文字は許容しないこと' do
    should validate_presence_of(:name)
  end

  test 'user作成時にデフォルトでnameが入ること' do
    user = User.create
    assert user.valid?
    assert user.name
  end
end
