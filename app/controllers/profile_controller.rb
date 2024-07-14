class ProfileController < ApplicationController
  before_action :user_authentication, only: %i[profile]

  def profile
    @posts = Post.where(user_id: session[:user_id])
    @subscribe_count = Subscribe.where(owner_id: session[:user_id]).count
  end

  def another_profile
    @user = User.find_by(id: params[:user_id])
    if @user.nil?
      head :bad_request
    else
      @posts = @user.post
      @subscribe_count = Subscribe.where(owner_id: params[:user_id]).count
      @is_subscribe = !Subscribe.find_by(user_id: session[:user_id], owner_id: params[:user_id]).nil?
    end
  end
end
