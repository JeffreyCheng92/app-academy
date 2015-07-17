class SessionsController < ApplicationController
  def new
    render :new
  end

  def create
    user = User.find_by_credentials(params[:user][:email],
                                    params[:user][:password])
    log_in!(user)
    redirect_to bands_url
  end

  def destroy
    log_out!(current_user)
    redirect_to new_session_url
  end

end
