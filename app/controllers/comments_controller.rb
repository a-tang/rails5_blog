class CommentsController < ApplicationController
  before_action :find_post
  before_action :authenticate_user!, except: [:index, :show]
  before_action :find_and_authorize_comment, only: :destroy

  def create
    @post = Post.find params[:post_id]
    @comment = Comment.new comment_params
    @comment.user = current_user
    @comment.post = @post
    if @comment.save
      redirect_to post_path(@post), notice: 'Comment created successfully'
    else
      render "/posts/show"
    end
  end

  def edit
      @comment = Comment.find params[:id]
  end

  def destroy
    @comment.destroy
    redirect_to post_path(@post), notice: "Comment Deleted!"
  end

  def update
    @comment = Comment.find params[:id]
    if @comment.update comment_params
      redirect_to post_path(@post)
    else
      render :edit
    end
  end

  private

  def find_post
    @post = Post.find params[:post_id]
  end

  def comment_params
    params.require(:comment).permit(:body)
  end

  def find_and_authorize_comment
    @comment = @post.comments.find params[:id]
    redirect_to home_path unless can? :destroy, @comment
  end

end
