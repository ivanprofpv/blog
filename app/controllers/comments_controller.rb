class CommentsController < ApplicationController
  before_action :authenticate_user!, only: %i[create update destroy edit new]
  before_action :set_comment, only: %i[edit update destroy]
  before_action :set_post, only: %i[create destroy edit update]

  def new
    @comment = Comment.new
  end

  def edit; end

  def create
    @comment = @post.comments.new(comment_params.merge(user: current_user))

    respond_to do |format|
      if @comment.save
        format.html { redirect_to post_path(@post), notice: 'Comment was successfully created.' }
        format.json { render :show, status: :created, location: @comment }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    @post = @comment.post
    @comment.update(comment_params)
    respond_to do |format|
      if @comment.update(comment_params)
        format.html { redirect_to post_path(@post), notice: 'Comment was successfully updated.' }
        format.json { render :show, status: :ok, location: @comment }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @comment.destroy

    flash[:good] = 'Comment deleted successfully.'
    redirect_to @post
  end

  private

  def set_comment
    @comment = Comment.find(params[:id])
  end

  def set_post
    @post = Post.find(params[:post_id])
  end

  def comment_params
    params.require(:comment).permit(:body)
  end
end
