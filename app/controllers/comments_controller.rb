class CommentsController < ApplicationController
  before_action :set_post, only: %i[create destroy]

  def create
    @comment = @post.comments.create(comment_params)
    @comment.user = current_user if user_signed_in?

    if @comment.save
      flash[:notice] = "Comment was successfully created."
      redirect_to post_path(@post)
    else
      flash[:alert] = @comment.errors.full_messages.join(" - ")
      redirect_to post_path(@post)
    end
  end

  def destroy
    @comment = @post.comments.find(params[:id])

    if @comment.destroy
      flash[:notice] = "Comment was successfully destroyed."
    else
      flash[:alert] = @comment.errors.full_messages.join(" - ")
    end
  end

  private

  def set_post
    @post = Post.find(params[:post_id])
  end

  def comment_params
    params.require(:comment).permit(:body)
  end
end
