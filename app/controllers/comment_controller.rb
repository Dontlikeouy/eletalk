class CommentController < ApplicationController
  before_action :user_authentication

  def create
    post_params = params.permit(:text)
    post_params[:user_id] = session[:user_id]
    post_params[:post_id] = params[:post_id]
    @comment = Comment.new(post_params)
    if @comment.save
      redirect_back(fallback_location: root_path)
    else
      head :bad_request
    end
  end

  def update
    @comment = Comment.find_by(id: params[:comment_id])
    if @comment.user_id.to_s != session[:user_id].to_s
      head :bad_request
      return
    end
    if @comment.nil?
      head :bad_request
    else
      post_params = params.require(:comment).permit(:text)
      if post_params[:text] == ''
        @comment.destroy
        redirect_back(fallback_location: root_path)
      elsif @comment.update(post_params)
        redirect_back(fallback_location: root_path)
      else
        head :bad_request
      end
    end
  end
end
