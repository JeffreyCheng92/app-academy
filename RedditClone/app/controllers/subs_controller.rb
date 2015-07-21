class SubsController < ApplicationController
  before_action :moderator?, only: [:edit, :update]

  def new
    @sub = Sub.new
  end

  def create
    @sub = current_user.subs.new(sub_params)

    if @sub.save
      redirect_to sub_url(@sub)
    else
      flash.now[:errors] = @sub.errors.full_messages
      render :new
    end
  end

  def edit
    render :edit
  end

  def update

    if @sub.update(sub_params)
      redirect_to sub_url(@sub)
    else
      flash.now[:errors] = @sub.errors.full_messages
      render :edit
    end
  end

  def index
    @subs = Sub.all #may need to include
  end

  def show
    @sub = Sub.find(params[:id])
    @posts = Post.joins(:post_subs).where('post_subs.sub_id = ?', @sub.id)
  end

  def moderator?
    @sub = Sub.find(params[:id])
    redirect_to subs_url unless current_user.id == @sub.moderator_id
  end

  def destroy
    @sub = Sub.find(params[:id])
    @sub.destroy
    redirect_to subs_url
  end

  private

  def sub_params
    params.require(:sub).permit(:title, :description)
  end
end
