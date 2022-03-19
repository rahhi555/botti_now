# frozen_string_literal: true

source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '3.1.0'

gem 'rails'
gem 'sprockets-rails'
gem 'pg'
gem 'puma', '~> 5.0'
gem 'importmap-rails'
gem 'turbo-rails'
gem 'stimulus-rails'
gem 'tailwindcss-rails'
gem 'redis'
gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]
gem 'bootsnap', require: false

gem 'slim-rails'
gem 'lograge'
gem 'gimei'
gem 'rails-i18n'
gem 'active_decorator'
gem 'sidekiq'
gem 'kaminari'
gem 'meta-tags'

group :development, :test do
  # require: falseにしないとsystem testで別セッション開いた時に終了しなくなる
  gem 'debug', platforms: %i[mri mingw x64_mingw], require: false
  gem 'awesome_print'
  gem 'bullet'
end

group :development do
  gem 'web-console'
  gem 'slim_lint'
  gem 'steep'
end

group :test do
  gem 'capybara'
  gem 'selenium-webdriver'
  gem 'webdrivers'
  gem 'shoulda-context'
  gem 'shoulda-matchers'
  gem 'simplecov', require: false
  gem 'minitest-stub_any_instance'
end
