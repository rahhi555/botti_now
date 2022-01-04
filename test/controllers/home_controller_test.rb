# frozen_string_literal: true

require 'test_helper'

class HomeControllerTest < ActionDispatch::IntegrationTest
  test 'トップページにアクセスできること' do
    assert_generates '/', controller: 'home', action: 'index'
    get root_url
    assert_response :success
  end
end
