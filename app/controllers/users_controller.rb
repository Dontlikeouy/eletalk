class UsersController < ApplicationController
  before_action :user_unauthentication, only: %i[index login]
  before_action :user_authentication, only: %i[logout]

  def index
    @user = User.new
  end

  def login
    @user_params = params.require(:user).permit(:email)
    @user = User.find_by(email: @user_params[:email])

    if @user.nil?
      @user = User.new(@user_params)
      unless @user.save
        render :index, status: :unprocessable_entity
        return
      end
    end

    redirect_to profile_path
    session[:user_id] = @user.id
  end

  def logout
    session.delete(:user_id)
    redirect_to root_path
  end
end
