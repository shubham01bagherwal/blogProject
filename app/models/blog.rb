class Blog < ApplicationRecord
  include Hashid::Rails

  has_one_attached :image, dependent: :destroy

  belongs_to :user

  has_many :comments, as: :commentable, dependent: :destroy

  has_many :likes, as: :likeable, dependent: :destroy

  default_scope -> { order(created_at: :desc) }

  scope :filter_by_name, lambda { |search|
    return if search.nil?
    where('name like ?', "%#{search}%")
  }

end