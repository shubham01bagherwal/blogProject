class RegistrationsController < ApplicationController
  skip_before_action :set_current_users
  before_action :set_current_users, only: [:edit, :update]
  before_action :set_user, only: [:edit, :update]
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
      @user.token.create(token_value: generate_token)
      UserMailer.account_varification(@user.id).deliver_later
      redirect_to root_path, notice: 'Successfully created account'
    else
      redirect_to '/registration/new', notice: @user.errors.full_messages.first
    end
  end

  def edit
  end

  def update
    if @user.update(user_params)
      session[:current_user] = @user
      redirect_to registrations_edit_path, notice: 'Successfully update account'
    else
      redirect_to welcome_error_path, notice: 'problem updateing user'
    end
  end

  def confirm_email
    @user = User.find(params[:user])
    if @user.present?
      if check_token(@user)
        @user.update_attribute(:email_confirmed, true)
        redirect_to root_path, notice: "Email confirmation success, please log-in"
      else
        redirect_to root_path(issue: @user.id), notice: "Email confirmation timeout, get a new confirmation mail"
      end
    else
      redirect_to sign_in_path
    end
  end

  def send_email_again
    @user = User.find(params[:id])
    @user.token.last.update_attribute(:token_value, generate_token)
    UserMailer.account_varification(@user.id).deliver_later
    redirect_to root_path, notice: "Check your email for confirmation link!!!"
  end
  
  private
  def set_user
    @user = User.find(session[:current_user]["id"])
  end

  def user_params
    params.require(:user).permit(:first_name, :last_name, :address, :city, :email, :password, :password_confirmation, :avatar)
  end

  def generate_token
    return SecureRandom.urlsafe_base64(nil, false)
  end

  def check_token(user)
    return true if ((Time.now - user.token.last.updated_at) <= 600)
  end

end
