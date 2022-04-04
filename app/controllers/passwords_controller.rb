class PasswordsController < ApplicationController
	
  def edit
    @user = User.find(session[:current_user]["id"])
  end
  
  def update
    if @current_user.update(password_params)
      redirect_to root_path, notice: 'Password Updated'
    else
      redirect_to edit_password_path, notice: @current_user.errors.full_messages.first
    end
  end
  
  private
    def password_params
      params.require(:user).permit(:password, :password_confirmation)
    end

end
