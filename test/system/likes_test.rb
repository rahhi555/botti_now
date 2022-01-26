require "application_system_test_case"
require 'debug'

class LikesTest < ApplicationSystemTestCase
  test 'いいねマークをクリックすると、いいねされること' do
    visit posts_url

    like_partial = find "#like_post_#{posts(:one).id}", visible: false

    like_partial.has_css?('.bg-green-600')

    like_partial.find_button.click
    like_partial.has_css?('.bg-pink-500')

  end
end
