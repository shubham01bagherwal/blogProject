class SessionsController < ApplicationController
  skip_before_action :set_current_users

  layout 'special'

	def new
      if session[:current_user]
        redirect_to blogs_path, notice: 'already loged in'
      end
	end
    
  def create
    user = User.find_by(email: params[:email])
    if user.present? && user.authenticate(params[:password])
      if user.email_confirmed == false
        redirect_to root_path, notice: 'please confirm your mail first'
      else
        session[:current_user] = user
        redirect_to blogs_path, notice: 'Logged in successfully'
      end
    else
      redirect_to root_path, notice: 'Invalid email or password'
    end
  end

  def destroy
    session[:current_user] = nil
    redirect_to root_path, notice: 'Logged Out'
  end

end