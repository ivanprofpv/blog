class PostsController < ApplicationController
  before_action :authenticate_user!, only: %i[create update destroy edit new]
  before_action :load_post, only: %i[show edit update destroy]

  def index
    public_post
  end

  def user_post
    user = current_user
    @posts = Post.user_posts(user)
  end

  def show; end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)

    @post.user = current_user

    respond_to do |format|
      if @post.save
        format.html { redirect_to post_url(@post), notice: 'Post was successfully created.' }
        format.json { render :show, status: :created, location: @post }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  def edit; end

  def update
    respond_to do |format|
      if @post.update(post_params)
        format.html { redirect_to post_url(@post), notice: 'Post was successfully updated.' }
        format.json { render :show, status: :ok, location: @post }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
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
    params.require(:post).permit(:title, :body, :attachment)
  end

  def public_post
    @posts = Post.where(is_active: true).order(created_at: :desc).page params[:page]
  end
end
