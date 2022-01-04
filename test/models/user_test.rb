# frozen_string_literal: true

require 'test_helper'

class UserTest < ActiveSupport::TestCase
  context 'postsが関連付けられていること' do
    should have_many(:posts).class_name('Post')
  end

  context 'uidにユニーク成約がかかっていること' do
    should validate_uniqueness_of(:uid)
  end
end
