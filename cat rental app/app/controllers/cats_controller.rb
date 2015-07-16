class CatsController < ApplicationController
  before_action :user_owns_cat, only: [:update, :edit]
  before_action :user_logged_in, only: [:create, :show]

  def index
    @cats = Cat.all
    render :index
  end

  def show
    @cat = Cat.includes(rental_requests: [:requester, :user]).find(params[:id])
    render :show
  end

  def new
    @cat = Cat.new
    render :new
  end

  def create
    @cat = Cat.new(cat_params)
    @cat.user_id = current_user.id

    if @cat.save
      redirect_to cat_url(@cat)
    else
      flash.now[:errors] = @cat.errors.full_messages
      render :new
    end
  end

  def edit
    @cat = Cat.find(params[:id])
    render :edit
  end

  def update
    @cat = Cat.find(params[:id])
    if @cat.update_attributes(cat_params)
      redirect_to cat_url(@cat)
    else
      flash.now[:errors] = @cat.errors.full_messages
      render :edit
    end
  end

  private

  def cat_params
    params.require(:cat)
      .permit(:age, :birth_date, :color, :description, :name, :sex)
  end

  def user_owns_cat
    redirect_to cats_url unless current_cat.user_id == current_user.id
  end

  def user_logged_in
   unless current_user
     flash[:errors] = ["Please log in"]
     redirect_to cats_url
   end
  end
end
