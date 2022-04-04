class Comment < ApplicationRecord

	has_many :comments, as: :commentable, dependent: :destroy

	belongs_to :commentable, polymorphic: true

	belongs_to :user, foreign_key: :user_id

	has_many :likes, as: :likeable, dependent: :destroy

	validates :comment_body, presence: true

	default_scope -> { order(created_at: :desc) }
end
