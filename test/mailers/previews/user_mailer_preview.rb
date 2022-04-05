# Preview all emails at http://localhost:3000/rails/mailers/user_mailer
class UserMailerPreview < ActionMailer::Preview
	def password_confirmation
		user = User.last
		UserMailer.password_confirmation(user)
	end
end
