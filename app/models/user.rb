# frozen_string_literal: true

class User < ApplicationRecord
  has_many :posts, dependent: :nullify
  has_many :likes, dependent: :nullify

  attribute :name, :string, default: "ぼっち #{Gimei.first}"

  validates :name, presence: true
end
