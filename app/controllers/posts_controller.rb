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
  
end
