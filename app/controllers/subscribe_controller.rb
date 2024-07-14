class SubscribeController < ApplicationController
  before_action :user_authentication

  def subscribe
    if params[:owner_id].to_s == session[:user_id].to_s
      head :bad_request
      return
    end
    @is_subscribe = Subscribe.find_by(user_id: session[:user_id], owner_id: params[:owner_id]).nil?
    unless @is_subscribe
      head :bad_request
      return
    end
    @subsceribe = Subscribe.new({ user_id: session[:user_id], owner_id: params[:owner_id] })
    if @subsceribe.save
      redirect_back(fallback_location: root_path)
    else
      head :bad_request
    end
  end

  def unsubscribe
    if params[:owner_id].to_s == session[:user_id].to_s
      head :bad_request
      return
    end
    Subscribe.where({ user_id: session[:user_id], owner_id: params[:owner_id] }).destroy_all
    redirect_back(fallback_location: root_path)
  end
end
