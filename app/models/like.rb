class Like < ApplicationRecord
  belongs_to :user
  belongs_to :post

  validates :user_id, uniqueness: { scope: :post, message: 'は同じコメントにいいね出来ません' }
  validate lambda {
    errors.add(:base, 'コメントの投稿者本人は、自分の投稿に対していいねを出来ません') if user_id == post.user_id
  }
end
