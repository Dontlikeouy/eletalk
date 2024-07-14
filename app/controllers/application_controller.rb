class ApplicationController < ActionController::Base
  private

  def user_signed_in?
    session[:user_id].present?
  end

  def user_authentication
    return if user_signed_in?

    redirect_to login_path
  end

  def user_unauthentication
    return unless user_signed_in?

    redirect_to profile_path
  end

  helper_method :user_signed_in?
end
