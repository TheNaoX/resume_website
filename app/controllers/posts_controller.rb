class PostsController < ApplicationController
  before_filter :authenticate_user!, except: [:index, :show]
  def index
    @posts = Post.all
    respond_to do |format|
      format.html
      format.json { render_for_api :post_details, json: @posts }
    end
  end

  def new
    @post = Post.new
  end
  
  def create
    @post = Post.new(params[:post].merge(author_id: current_user.id))
    respond_to do |format|
      if @post.save
        flash[:success] = "Successfully created new post #{@post.title}"
        format.html { redirect_to posts_path }
      else
        format.html { render :new }
      end
    end
  end

  def show
    @post = Post.find(params[:id])
    respond_to do |format|
      format.json { render_for_api :post_details, json: @post }
    end
  end

  def destroy
    @post = Post.find(params[:id])
    respond_to do |format|
      if @post.delete
        flash[:success] = "Successfully deleted new post #{@post.title}"
        format.html { redirect_to posts_path }
      else
        flash[:alert] = "Could not delete post: #{@post.title}, try again later"
        format.html { redirect_to posts_path }
      end
    end
  end

  def like
    @like = Like.new(post_id: params[:post_id], user_id: current_user.id)
    respond_to do |format|
      if @like.save
        @post = Post.find(params[:post_id])
        format.json { render json: { status: 200, message: @post.pretty_print_likes } }
      else
        format.json { render json: { status: 500, message: "Internal server error" } }
      end
    end
  end

  def unlike
    @like = Like.where(post_id: params[:post_id], user_id: current_user.id).shift
    respond_to do |format|
      if @like.destroy
        @post = Post.find(params[:post_id])
        format.json { render json: { status: 200, message: @post.pretty_print_likes, likes_count: @post.likes.count } }
      else
        format.json { render json: { status: 500, message: "Internal server error" } }
      end
    end
  end

  private
  
  def not_allowed_to_destroy_post
    flash[:alert] = "You're not allowed to destroy this post"
    redirect_to posts_path
  end

end
