class UserMailer < ApplicationMailer
	default from: 'shubhamnamdevblog1@gmail.com'
  layout 'mailer'

	def account_varification(user_id)
		@user = User.find(user_id)
		mail(to: @user.email, subject: 'please confirm your email')
	end

	def comment_mail(comment_id)
		@comment = Comment.find(comment_id)
		mail(to: @comment.commentable.user.email, subject: 'you got notification')
	end

	def like_mail(like_id)
		@like = Like.find(like_id)
		mail(to: @like.likeable.user.email, subject: 'you got new like')
	end

end
