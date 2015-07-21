class PostsController < ApplicationController
  before_action :author?, only: [:edit, :update, :destroy]

  def edit
    @post = Post.find(params[:id])
    @subs = Sub.all

  end

  def update
    @post = Post.find(params[:id])
    @subs = Sub.all
    if @post.update(post_params)
      redirect_to post_url(@post)
    else
      flash.now[:errors] = @post.errors.full_messages
      render :edit
    end
  end

  def destroy
    @post = Post.find(params[:id])
    @sub = @post.sub_id
    @post.destroy
    redirect_to sub_url(@sub)
  end

  def create
    @post = current_user.posts.new(post_params)
    @subs = Sub.all
    if @post.save
      redirect_to post_content_url(@post)
    else
      flash.now[:errors] = @post.errors.full_messages
      render :new
    end
  end

  def new
    @post = Post.new
    @subs = Sub.all
  end

  def show
    @post = Post.find(params[:id])
    if @post.url.nil? || @post.url.empty?
      @comments = @post.comments#.includes(:child_comments)
      render :content
    else
      redirect_to @post.url
    end
  end

  def content
    @post = Post.find(params[:post_id])
    @comments = @post.comments#.includes(:child_comments)
    render :content
  end

  private
  def author?
    @post = Post.find(params[:id])

    unless current_user.id == @post.author_id
      redirect_to sub_url(@post.id)
    end
  end

  def post_params
    params.require(:post).permit(:title, :content, :url, sub_ids: [])
  end
end
