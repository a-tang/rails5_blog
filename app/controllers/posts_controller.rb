class PostsController < ApplicationController
before_action :find_post, only: [:show, :edit, :update, :destroy]
before_action :authenticate_user!, except: [:index, :show]

  def new
    @post = Post.new
  end

  def update
    if @post.update post_params
      # redirect_to post_path(@post)
      redirect_to root_path, alert: "access defined" unless can? :update, @post
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
    redirect_to root_path, alert: "access defined" unless can? :destroy, @post
  end

  def edit
    redirect_to root_path, alert: "access defined" unless can? :edit, @post
  end

  def index
    @posts = Post.all
    @post_total = Post.count
    if params[:search]
      @posts = Post.search(params[:search]).order("created_at DESC")
    else
      @posts = Post.all.order('created_at DESC')
    end
    @posts = @posts.page(params[:page]).per(10)
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

  def find_owned_post
    @post = current_user.posts.find params[:id]
  end

  def like_for(user)
   likes.find_by_user_id user if user
  end

  def user_like
    @user_like ||= @post.like_for(current_user)
  end
  helper_method :user_like

end
