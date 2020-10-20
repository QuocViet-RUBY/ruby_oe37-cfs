class PasswordResetsController < ApplicationController
  before_action :check_logged, except: [:new, :create, :edit, :update]
  before_action :get_user, :valid_user, only: [:edit, :update]
  before_action :check_expiration, only: [:edit, :update]
  def new; end

  def create
    if (@user = User
      .find_by email: params[:password_reset][:email].downcase)
      @user.create_reset_digest
      @user.send_password_reset_email
      flash[:info] = t "account.create_infor"
      redirect_to login_url
    else
      flash.now[:danger] = t "account.create_danger"
      render :new
    end
  end

  def update
    if params[:user][:password].empty?
      @user.errors.add(:password, t("account.update_mgs"))
      render :edit
    elsif @user.update(user_params)
      log_in @user
      flash[:success] = t "account.update_success"
      redirect_to @user
    else
      render :edit
    end
  end

  def edit; end

  private

  def user_params
    params.require(:user).permit(:password, :password_confirmation)
  end

  def get_user
    return if @user = User.find_by(email: params[:email])

    flash[:danger] = t "form.found"
    redirect_to root_path
  end

  def valid_user
    return if @user.activated? && @user.authenticated?(:reset, params[:id])

    redirect_to root_url
  end

  def check_expiration
    return unless @user.password_reset_expired?

    flash[:danger] = t "account.expired"
    redirect_to new_password_reset_url
  end
end
