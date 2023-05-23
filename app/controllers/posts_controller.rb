class PostsController < ApplicationController
  before_action :load_post, only: %i[show edit update destroy]

  def index
    @posts = Post.order(created_at: :desc)
  end

  def show; end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)

    @post.user = current_user

    if @post.save
      flash[:good] = 'Post created successfully.'
      redirect_to @post
    end
  end

  def edit; end

  def update
    if @post.update(post_params)
      flash[:good] = 'Post updated successfully.'
      redirect_to @post
    else
      render :edit
    end
  end

  def destroy
    @post.destroy
    flash[:good] = 'Post deleted successfully.'
    redirect_to root_path
  end

  private

  def load_post
    @post = Post.find(params[:id])
  end

  def post_params
    params.require(:post).permit(:title, :body)
  end
end
