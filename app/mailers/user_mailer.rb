class UserMailer < ApplicationMailer
default from: 'shubhamnamdevblog1@gmail.com'
  layout 'mailer'

	def password_confirmation(user)
		@user = user
		mail(to: @user.email, subject: 'confirmation email')
	end
end
