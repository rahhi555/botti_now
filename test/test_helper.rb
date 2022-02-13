# frozen_string_literal: true

ENV['RAILS_ENV'] ||= 'test'

require 'simplecov'
SimpleCov.start
require_relative '../config/environment'
require 'rails/test_help'

module ActiveSupport
  class TestCase
    # Run tests in parallel with specified workers
    parallelize(workers: :number_of_processors)

    # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
    fixtures :all

    # Add more helper methods to be used by all tests here...
  end
end

Shoulda::Matchers.configure do |config|
  config.integrate do |with|
    with.test_framework :minitest
    with.library :rails
  end
end

# @param [Integer] create_count 何行投稿を作成するか
# 引数分の投稿を作成する
def create_list_post(create_count)
  result = User.insert_all!([{ name: 'dummy' }] * create_count)
  # @type var rows: Array[{ id: String, message: 'dummy text' }]
  rows = result.flat_map do |row|
    { user_id: row['id'], message: 'dummy text' }
  end
  Post.insert_all!(rows)
end
