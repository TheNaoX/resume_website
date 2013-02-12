class PostsController < ApplicationController
  before_filter :authenticate_user!, except: [:index]
  def index
    @posts = Post.all
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

end
