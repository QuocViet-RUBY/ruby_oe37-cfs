class AccountActivationsController < ApplicationController
  def edit
    user = User.find_by(email: params[:email])
    if !user&.activated? && user&.authenticated?(:activation, params[:id])
      user.activate
      log_in user
      flash[:success] = t "account.active"
      redirect_to root_url
    else
      flash[:danger] = t "account.in_active"
      redirect_to login_url
    end
  end
end
