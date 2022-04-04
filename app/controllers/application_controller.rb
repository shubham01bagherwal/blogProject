class ApplicationController < ActionController::Base

  before_action :set_current_users

  def set_current_users
    @current_user = User.find(session[:current_user]["id"]) if session[:current_user]
    redirect_to sign_in_path unless @current_user
  end


  def confirm_email
    user = User.find_by_confirm_token(params[:id])
    if user
      user.email_activate
      flash[:success] = "Welcome to the Sample App! Your email has been confirmed.
      Please sign in to continue."
      redirect_to signin_url
    else
      flash[:error] = "Sorry. User does not exist"
      redirect_to root_url
    end
  end
end
