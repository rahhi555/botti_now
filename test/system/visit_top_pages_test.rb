# frozen_string_literal: true

require 'application_system_test_case'

class VisitTopPagesTest < ApplicationSystemTestCase
  test 'トップページにアクセスし、ツイートページのリンクを踏む' do
    visit root_url

    assert_selector 'a', text: 'つぶやく'

    assert_changes -> { User.count } do
      click_link 'つぶやく'
    end

    assert has_current_path?(posts_url)
  end
end
