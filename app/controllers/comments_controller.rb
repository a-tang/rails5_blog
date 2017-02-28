class CommentsController < ApplicationController
  before_action :find_post
  before_action :authenticate_user!, except: [:index, :show]

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
  end

  def destroy
    @comment.destroy
    redirect_to comments_path
  end

  def update
    if @comment.update comment_params
      redirect_to comment_path(@comment)
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

end
