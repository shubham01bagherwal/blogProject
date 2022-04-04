class User < ApplicationRecord
	include Hashid::Rails

	has_secure_password
	has_one_attached :avatar, dependent: :destroy

	has_many :blogs, dependent: :destroy
	has_many :comments, dependent: :destroy
	has_many :likes, as: :likeable, dependent: :destroy

	validates :email, presence: true, uniqueness: true
	validates :password, confirmation: true, confirmation: { case_sensitive: true }

	
end
