class RegistrationsController < ApplicationController
  skip_before_action :set_current_users
  before_action :set_current_users, only: [:edit, :update]

	layout 'special', only: [:new, :create]

	  def new
      if @current_user.present?
        redirect_to blogs_path
      end
      @user = User.new
    end

    def create
      @user = User.new(user_params)
      @user.avatar.attach(params[:avatar]) if params[:avatar].present?
      if @user.save
        session[:current_user] = @user
        UserMailer.registration_confirmation(@user).deliver
        flash[:success] = "please confirm your email address to continue"
        redirect_to root_path, notice: 'please confirm your email address to continue'
      else
        redirect_to '/registration/new', notice: @user.errors.full_messages.first
      end
    end

    def edit
      @user = User.find(session[:current_user]["id"])
    end

    def update
      @user = User.find(session[:current_user]["id"])
      if @user.update(user_params)
        session[:current_user] = @user
        redirect_to registrations_edit_path, notice: 'Successfully update account'
      else
        redirect_to welcome_error_path, notice: 'problem updateing user'
      end
    end

    def confirm_email
      user = User.find_by_confirm_token(params[:id])
      if user 
        user.email_activate
        flash[:sucess] = "Welcome to the App please sign in to continue"
        redirect_to sign_in_path
      else
        flash[:error] = "User does not exist"
        redirect_to root_path
      end
    end
    
    private
    def user_params
      params.require(:user).permit(:first_name, :last_name, :address, :city, :email, :password, :password_confirmation, :avatar)
    end

end
