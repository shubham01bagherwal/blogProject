class User < ApplicationRecord
	include Hashid::Rails
  before_create :confirmation_token

	has_secure_password
	has_one_attached :avatar, dependent: :destroy

	has_many :blogs, dependent: :destroy
	has_many :comments, dependent: :destroy
	has_many :likes, as: :likeable, dependent: :destroy

	validates :email, presence: true, uniqueness: true
	validates :password, confirmation: true, confirmation: { case_sensitive: true }


	private
	def confirmation_token
    if self.confirm_token.blank?
      self.confirm_token = SecureRandom.urlsafe_base64.to_s
    end
  end

  def email_activate
    self.email_confirmed = true
    self.confirm_token = nil
    save!(:validate => false)
  end

	
end
