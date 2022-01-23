# frozen_string_literal: true

class Post < ApplicationRecord
  has_many :likes
  belongs_to :user
  after_create_commit -> { broadcast_append_to 'tweet_page' }

  validates :message, length: { maximum: 255 }, presence: true
end
