class ApplicationController < ActionController::Base

  before_action :set_current_users

  def set_current_users
    @current_user = User.find(session[:current_user]["id"]) if session[:current_user]

    redirect_to sign_in_path unless @current_user
  end

end
