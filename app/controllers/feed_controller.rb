class FeedController < ApplicationController
  def index
    if Post.count.zero?
      redirect_to profile_path
    else
      @post = Post.find(Post.pluck(:id).sample)

      redirect_to feed_path(post_id: @post.id)
    end
  end

  def next_post
    if Post.count == params[:post_id].to_i + 1
      redirect_to feed_path(post_id: params[:post_id].to_i + 1)
    else
      @post = Post.first
      redirect_to feed_path(post_id: @post.id)
    end
  end

  def feed
    @post = Post.find_by(id: params[:post_id])
    if @post.nil?
      head :bad_request
    else
      @comment = Comment.new
      @comments = @post.comment
      @comment_count = @comments.count
      @favorite_count = @post.favorite.count
      @another_user = @post.user

      if @favorite_count >= 100_000_000
        @favorite_count = '>100M'
      elsif @favorite_count >= 1_000_000
        @favorite_count /= 1_000_000
        @favorite_count = "#{@favorite_count}M"
      elsif @favorite_count >= 1000
        @favorite_count /= 1000
        @favorite_count = "#{@favorite_count}T"
      elsif @favorite_count >= 100
        @favorite_count /= 100
        @favorite_count = "#{@favorite_count}H"
      end
      @is_favorite = !Favorite.find_by(user_id: session[:user_id], post_id: @post.id).nil?
      @is_subscribe = !Subscribe.find_by(user_id: session[:user_id], owner_id: @post.user_id).nil?
    end
  end
end
