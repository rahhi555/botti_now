# frozen_string_literal: true

class Post < ApplicationRecord
  has_many :likes, dependent: :destroy
  belongs_to :user

  validates :message, length: { maximum: 255 }, presence: true
end
