# frozen_string_literal: true

require 'test_helper'

class PostTest < ActiveSupport::TestCase
  context 'userがbelong_toとして関連付けられていること' do
    should belong_to(:user).class_name('User')
  end

  context 'messageは255文字までであること' do
    should validate_length_of(:message)
  end
end
