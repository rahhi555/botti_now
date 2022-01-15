# frozen_string_literal: true

class Post < ApplicationRecord
  belongs_to :user, dependent: :destroy

  validates :message, length: { maximum: 255 }, presence: true
end
