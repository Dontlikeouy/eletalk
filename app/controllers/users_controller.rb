class UsersController < ApplicationController
  before_action :user_unauthentication, only: %i[index create]
  before_action :user_authentication, only: %i[logout edit update]

  def index
    @user = User.new
  end

  def edit
    @user = User.find_by({ id: session[:user_id] })
  end

  def create
    @user_params = params.require(:user).permit(:email)
    @user = User.find_by(email: @user_params[:email])

    if @user.nil?
      @user_params[:username] = "unknown##{Post.count}"
      @user = User.new(@user_params)
      unless @user.save
        render :index, status: :unprocessable_entity
        return
      end
    end

    redirect_to username_edit_path
    session[:user_id] = @user.id
    session[:username] = @user.username
  end

  def update
    @user = User.find_by({ id: session[:user_id] })

    @user_params = params.require(:user).permit(:username)

    unless @user.update(@user_params)
      render :edit, status: :unprocessable_entity
      return
    end
    session[:username] = @user.username

    redirect_to profile_path
  end

  def logout
    session.delete(:user_id)
    redirect_to root_path
  end
end
