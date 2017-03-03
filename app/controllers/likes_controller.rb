class LikesController < ApplicationController

  before_action :authenticate_user!
  before_action :authorize_create, only: :create
  before_action :authorize_destroy, only: :destroy

  def create
    like           = Like.new
    like.user      = current_user
    like.post      = post
    if like.save
      redirect_to post, notice: "Liked!"
    else
      redirect_to post, alert: "You're already liked this post!"
    end
  end

  def index
    @likes = current_user.likes
  end

  def destroy
    like.destroy
    redirect_to post_path(like.post_id), notice: "Un-liked!"
  end


  private

  def authorize_create
    redirect_to post, notice: "You can't like your own post!" unless can? :like, post
  end

  def authorize_destroy
    redirect_to post, notice: "Can't remove like!" unless can? :destroy, like
  end

  def post
    @post ||= Post.find params[:post_id]
  end

  def like
    @like ||= Like.find params[:id]
  end

end
