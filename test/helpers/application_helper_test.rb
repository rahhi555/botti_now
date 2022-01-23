require 'test_helper'
require 'debug'

class ApplicationHelperTest < ActionView::TestCase
  test 'current_userメソッドは、session_idが無ければnilを返す' do
    assert_nil session[:user_id]
    assert_nil current_user
  end

  test 'current_userメソッドは、session_idがあればユーザーを返す' do
    session[:user_id] = users(:one).id
    assert session[:user_id]
    assert_equal users(:one), current_user
  end
end
