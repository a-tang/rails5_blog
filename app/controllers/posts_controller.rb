class PostsController < ApplicationController
before_action :find_post, only: [:show, :edit, :update, :destroy]
before_action :authenticate_user!, except: [:index, :show]

  def new
    @post = Post.new
  end

  def update
    if @post.update post_params
      redirect_to post_path(@post)
    else
      render :edit
    end
  end

  def create
    @post = Post.new post_params
    @post.user = current_user
    if @post.save
      redirect_to post_path(@post), notice: 'Post created successfully'
    else
      render :new
    end
  end

  def destroy
    @post.destroy
    redirect_to posts_path
  end

  def edit
  end

  def index
    @posts = Post.all
    if params[:search]
      @posts = Post.search(params[:search]).order("created_at DESC")
    else
      @posts = Post.all.order('created_at DESC')
    end
  end

  def show
    @comment = Comment.new
  end

  private

  def post_params
    params.require(:post).permit(:title, :body)
  end

  def find_post
    @post = Post.find params[:id]
  end

end
