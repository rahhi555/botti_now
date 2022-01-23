# frozen_string_literal: true

require 'test_helper'

class PostDecoratorTest < ActiveSupport::TestCase
  def setup
    @post = Post.new.extend PostDecorator
    @post.attributes = { message: 'テストメッセージ', user_id: users(:one).id }
  end

  test '直近に作成されたpostの場合、bubble_styleのdelayが0であること' do
    @post.save!
    assert_match /tweet-bubble \d{1,2}s 0s/, @post.reload.bubble_style
  end

  test '以前に作成されたpostの場合、bubble_styleのdelayは0以外であること' do
    travel_to Time.current - 30 do
      @post.save!
    end
    assert_match /tweet-bubble \d{1,2}s [^0]\d?s/, @post.reload.bubble_style
  end
end
