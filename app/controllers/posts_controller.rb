class PostsController < ApplicationController
  before_action :user_authentication

  def new
    @post = Post.new
  end

  def edit
    @post = Post.find_by(id: params[:post_id])
    return unless @post.nil? || @post.user_id.to_s != session[:user_id].to_s

    head :bad_request
  end

  def create
    post_params = params.require(:post).permit(:title, :description, :image)

    post_params[:user_id] = session[:user_id]
    @post = Post.new(post_params)
    if @post.save
      redirect_to profile_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    @post = Post.find_by(id: params[:post_id])

    if @post.nil? || @post.user_id.to_s != session[:user_id].to_s
      head :bad_request
    else
      post_params = params.require(:post).permit(:title, :description, :image)
      post_params[:user_id] = session[:user_id]
      if @post.update(post_params)
        redirect_to profile_path
      else
        render :edit, status: :unprocessable_entity
      end
    end
  end

  def destroy
    @post = Post.find_by(id: params[:post_id])
    if @post.nil? || @post.user_id.to_s != session[:user_id].to_s
      head :bad_request
    else
      @post.destroy
      redirect_to profile_path
    end
  end
end
