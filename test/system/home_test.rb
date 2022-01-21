# frozen_string_literal: true

require 'application_system_test_case'

class HomeTest < ApplicationSystemTestCase
  test 'トップページにアクセスし、ツイートページのリンクを踏むと、ユーザーが新規作成される' do
    visit root_url

    assert_selector 'a', text: 'つぶやく'

    click_link 'つぶやく'

    assert has_current_path?(posts_url)

    assert 1, User.count - users.count
  end
end
