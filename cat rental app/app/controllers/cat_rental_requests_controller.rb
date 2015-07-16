class CatRentalRequestsController < ApplicationController
  before_action :user_owns_cat_rental_request, only: [:approve, :deny]
  before_action :user_logged_in, only: [:create]

  def approve
    current_cat_rental_request.approve!
    redirect_to cat_url(current_cat)
  end

  def create
    @rental_request = CatRentalRequest.new(cat_rental_request_params)
    @rental_request.user_id = current_user.id
    if @rental_request.save
      redirect_to cat_url(@rental_request.cat)
    else
      flash.now[:errors] = @rental_request.errors.full_messages
      render :new
    end
  end

  def deny
    current_cat_rental_request.deny!
    redirect_to cat_url(current_cat)
  end

  def new
    @rental_request = CatRentalRequest.new
  end

  def current_cat
    current_cat_rental_request.cat
  end

  def cat_rental_request_params
    params.require(:cat_rental_request)
      .permit(:cat_id, :end_date, :start_date, :status)
  end

  def user_owns_cat_rental_request
    redirect_to cats_url unless current_cat_rental_request.user.id == current_user.id
  end

  def user_logged_in
   unless current_user
     flash[:errors] = ["Please log in"]
     redirect_to cats_url
   end
  end
end
