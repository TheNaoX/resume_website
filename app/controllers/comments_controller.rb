class CommentsController < ApplicationController

  respond_to :json


  def create
    @comment = Comment.new(post_id: params[:post_id], user_id: current_user.id, comment: params[:comment])
    if @comment.save
      respond_with(@comment, location: "/comments/#{@comment.id}")
    else
      respond_with(@comment.errors, status: :unprocessable_entity, message: "We're sorry but something went wrong, try later")
    end
  end

  def show
    @comment = Comment.find(params[:id])
    respond_with(@comment)
  end
end
