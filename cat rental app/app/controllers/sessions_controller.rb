class SessionsController < ApplicationController
  before_action :logged_in?, only: [:destroy]

  def new
    @user = User.new
    render :new
  end

  def create
    @user = find_by_credentials(params[:user][:user_name], params[:user][:password])
    if @user
      log_in!(@user)
    else
      flash.now[:errors] = ["Invalid Log In"]
      render :new
    end
  end

  def destroy
    user = current_user
    log_out!(user)
    redirect_to new_session_url
  end

end
