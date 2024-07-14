class FavoriteController < ApplicationController
  before_action :user_authentication

  def favorite
    @is_favorite = Favorite.find_by(user_id: session[:user_id], post_id: params[:post_id]).nil?
    unless @is_favorite
      head :bad_request
      return
    end
    @favorite = Favorite.create({ user_id: session[:user_id], post_id: params[:post_id] })
    if @favorite.save
      redirect_back(fallback_location: root_path)
    else
      head :bad_request
    end
  end

  def unfavorite
    @favorite = Favorite.find_by(user_id: session[:user_id], post_id: params[:post_id])
    if @favorite.nil?
      head :bad_request
      return
    end
    @favorite.destroy

    redirect_back(fallback_location: root_path)
  end
end
