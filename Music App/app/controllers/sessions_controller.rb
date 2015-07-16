class SessionsController < ApplicationController

  def new
    render :new
  end

  def create
    current_user.reset_session_token
    session[:session_token] = current_user[:session_token]
  end

  def destroy
    current_user.reset_session_token
    session[session_token] = nil
  end

end
