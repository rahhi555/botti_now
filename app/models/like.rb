class Like < ApplicationRecord
  belongs_to :user
  belongs_to :post

  validates :user_id, uniqueness: { scope: :post, message: 'は同じコメントにいいね出来ません' }
end
