class PostsController < ApplicationController
  before_action :set_post, only: %i[ show edit update destroy ]
  before_action :authenticate_user!, except: %i[ index show ]

  def index
    @pagy, @posts = pagy(Post.most_recent, items: 3)
  end

  def show
    @pagy, @comments = pagy(@post.comments.order(created_at: :desc), items: 3)
  end

  def new
    @post = Post.new
  end

  def edit
    redirect_to post_path(@post), alert: "You are not the owner of this post." if can_not_manage?
  end

  def create
    @post = Post.new(post_params)
    @post.user = current_user

    if @post.save
      redirect_to post_path(@post), notice: "Post was successfully created."
    else
      redirect_to new_post_path, alert: @post.errors.full_messages.join(" - ")
    end
  end

  def update
    if @post.update(post_params)
      redirect_to post_path(@post), notice: "Post was successfully updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @post.destroy!
    redirect_to posts_path, notice: "Post was successfully destroyed."
  end

  private

  def set_post
    @post = Post.find(params[:id])
  end

  def post_params
    params.require(:post).permit(:title, :body)
  end

  def can_not_manage?
    @post.user != current_user
  end
end
