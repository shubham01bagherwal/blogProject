class UserMailer < ApplicationMailer
	default :from => "applicationname@domain.com"

	def registration_confirmation(user)
    @user = user
    mail(:to => "<#{user.email}>", :subject => "Registration Confirmation")
	end
end
