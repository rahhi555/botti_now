# frozen_string_literal: true

class Post < ApplicationRecord
  has_many :likes, dependent: :destroy
  belongs_to :user

  validates :message, length: { maximum: 50 }, presence: true

  # いいねをlike_countとして含めた上で、like_countの降順で投稿一覧を取得する
  scope :desc_likes_count, lambda {
    select('posts.*, COALESCE(COUNT, 0) AS like_count')
      .joins(
        <<~JOIN
          LEFT JOIN (
            SELECT
              post_id, COUNT(*)
            FROM
              likes
            GROUP BY post_id
          ) AS likes_table
          ON
            posts.id = likes_table.post_id
        JOIN
      )
      .order(like_count: :desc)
  }

end
