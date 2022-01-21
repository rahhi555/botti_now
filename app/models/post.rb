# frozen_string_literal: true

class Post < ApplicationRecord
  belongs_to :user
  broadcasts_to ->(_) { 'tweet_page' }

  validates :message, length: { maximum: 255 }, presence: true
end
