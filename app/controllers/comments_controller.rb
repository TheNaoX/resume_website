class CommentsController < ApplicationController
  def create
    @comment = Comment.new(post_id: params[:post_id], user_id: current_user.id, comment: params[:comment])
    respond_to do |format|
      if @comment.save
        format.json { render json: { status: 200, comment: @comment, message: 'Successfully created comment', user: current_user} }
      else
        format.json { render json: { status: 500, message: "We're sorry but something went wrong, try later" } }
      end
    end
  end
end
