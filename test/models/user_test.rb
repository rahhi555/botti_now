# frozen_string_literal: true

require 'test_helper'

class UserTest < ActiveSupport::TestCase
  context 'postsが関連付けられていること' do
    should have_many(:posts).class_name('Post')
  end
end
