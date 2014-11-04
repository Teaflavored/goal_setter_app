class CommentsController < ApplicationController
  before_action :redirect_if_not_your_comment, only: [:edit, :update]
  def create
    @comment = Comment.new(comment_params)
    @comment.author = current_user
    
    if @comment.save
      redirect_to @comment.commentable
    else
      flash[:errors] = @comment.errors.full_messages
      redirect_to @comment.commentable
    end
  end
  
  def edit
    @comment = Comment.find(params[:id])
  end
  
  def update
    @comment = Comment.find(params[:id])
    if @comment.update(comment_params)
      redirect_to @comment.commentable
    else
      flash[:errors] = @comment.errors.full_messages
      redirect_to @comment.commentable
    end
  end
  
  private
  
  def comment_params
    params.require(:comment).permit(:content, :commentable_id, :commentable_type)
  end
  
  def redirect_if_not_your_comment
    redirect_to root_url unless current_user == Comment.find(params[:id]).author
  end
end
