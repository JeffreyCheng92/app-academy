class CommentsController < ApplicationController

  def create
    @comment = current_user.comments.new(comment_params)

    unless @comment.save
      flash.new[:errors] = @comment.errors.full_messages
    end

    redirect_to post_url(@comment.post_id)
  end

  def destroy
  end

  def show
    @comment = Comment.find(params[:id])
    @children = @comment.comments
  end

  def edit
  end

  def update
  end

  private
  def comment_params
    params.require(:comment).permit(:content,
                                    :commentable_id,
                                    :commentable_type,
                                    :post_id,
                                    :parent_comment_id)
  end
end
