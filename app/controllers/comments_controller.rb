class CommentsController < ApplicationController
  def create
    comment = Comment.new(comment_params)
    if comment.save
      flash[:notice] = 'コメントを投稿しました'
      redirect_to comment.recipe
    else
      if comment.reply_comment.nil?
        flash[:comment] = comment
      else
        flash[:comment_reply] = comment
      end

      flash[:error_messages] = comment.errors.full_messages
      redirect_back fallback_location: comment.recipe
    end
  end

  def destroy
    comment = Comment.find_by(id: params[:id], recipe_id: params[:recipe_id]).destroy
    redirect_to comment.recipe, flash: { notice: 'コメントが削除されました' }
  end

  private

  def comment_params
    params.require(:comment).permit(:user_id, :recipe_id, :reply_comment, :name, :content)
  end
end
