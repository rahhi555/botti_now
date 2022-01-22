# frozen_string_literal: true

class Post < ApplicationRecord
  belongs_to :user
  after_create_commit -> { broadcast_append_to 'tweet_page' }

  validates :message, length: { maximum: 255 }, presence: true
end
