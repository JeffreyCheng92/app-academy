class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  helper_method :current_user, :current_cat_rental_request, :current_cat

  def current_session
    @session ||= Session.find_by(token: current_user.session_token)
  end

  def current_cat
    @cat ||= Cat.find_by(id: params[:id])
  end

  def current_cat_rental_request
    @rental_request ||=
      CatRentalRequest.includes(:cat, :user).find(params[:id])
  end

  def find_by_credentials(username, password)
    user = User.find_by(user_name: username)
    return (user && user.is_password?(password)) ? user : nil
  end

  def log_in!(user)
    session[:session_token] = SessionToken.generate_session_token
    SessionToken.create!(user_id: @user.id, token: session[:session_token])
    redirect_to cats_url
  end

  def current_user
    @current_user ||= User.find_by(:id = <<-SQL, session[:session_token])
      SELECT
        user_id
      FROM
        session_tokens
      WHERE
        session_tokens.token = ?
    SQL
  end

  def log_out!(user)
    current_session.destroy!
    session[:session_token] = nil
  end

  def user_params
    params.require(:user).permit(:user_name, :password)
  end

  def logged_in?
    redirect_to new_session_url unless current_user
  end
end
